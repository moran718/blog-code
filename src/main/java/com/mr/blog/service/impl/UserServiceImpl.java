package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mr.blog.common.Result;
import com.mr.blog.dto.LoginRequest;
import com.mr.blog.dto.RegisterRequest;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.MailService;
import com.mr.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private MailService mailService;

    // Redis key 前缀
    private static final String CODE_PREFIX = "blog:code:";

    // 验证码有效期5分钟
    private static final long CODE_EXPIRE_TIME = 5;

    @Override
    public Result<User> register(RegisterRequest request) {
        // 参数校验
        if (!StringUtils.hasText(request.getUsername())) {
            return Result.error("用户名不能为空");
        }
        if (!StringUtils.hasText(request.getEmail())) {
            return Result.error("邮箱不能为空");
        }
        if (!StringUtils.hasText(request.getPassword())) {
            return Result.error("密码不能为空");
        }
        if (!StringUtils.hasText(request.getCode())) {
            return Result.error("验证码不能为空");
        }

        // 验证验证码
        if (!verifyCode(request.getEmail(), request.getCode())) {
            return Result.error("验证码错误或已过期");
        }

        // 检查用户名是否已存在
        LambdaQueryWrapper<User> usernameWrapper = new LambdaQueryWrapper<>();
        usernameWrapper.eq(User::getUsername, request.getUsername());
        if (this.count(usernameWrapper) > 0) {
            return Result.error("用户名已存在");
        }

        // 检查邮箱是否已存在
        LambdaQueryWrapper<User> emailWrapper = new LambdaQueryWrapper<>();
        emailWrapper.eq(User::getEmail, request.getEmail());
        if (this.count(emailWrapper) > 0) {
            return Result.error("邮箱已被注册");
        }

        // 创建用户
        User user = new User();
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        // 密码MD5加密
        user.setPassword(DigestUtils.md5DigestAsHex(request.getPassword().getBytes()));
        user.setGender(0);
        user.setAvatar("https://api.dicebear.com/7.x/avataaars/svg?seed=" + request.getUsername());
        user.setBio("");
        user.setLevel(1);
        user.setTitle("新人");
        user.setCreateTime(LocalDateTime.now());
        user.setUpdateTime(LocalDateTime.now());

        this.save(user);

        // 清除验证码
        redisTemplate.delete(CODE_PREFIX + request.getEmail());

        // 返回时不包含密码
        user.setPassword(null);
        return Result.success("注册成功", user);
    }

    @Override
    public Result<User> login(LoginRequest request) {
        if (!StringUtils.hasText(request.getEmail())) {
            return Result.error("邮箱不能为空");
        }

        // 根据邮箱查询用户
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getEmail, request.getEmail());
        User user = this.getOne(wrapper);

        // 密码登录
        if ("password".equals(request.getLoginType())) {
            if (user == null) {
                return Result.error("用户不存在，请先注册或使用免密登录");
            }
            if (!StringUtils.hasText(request.getPassword())) {
                return Result.error("密码不能为空");
            }
            String encryptedPassword = DigestUtils.md5DigestAsHex(request.getPassword().getBytes());
            if (!encryptedPassword.equals(user.getPassword())) {
                return Result.error("密码错误");
            }
        }
        // 验证码登录（免密登录）
        else if ("code".equals(request.getLoginType())) {
            if (!StringUtils.hasText(request.getCode())) {
                return Result.error("验证码不能为空");
            }
            if (!verifyCode(request.getEmail(), request.getCode())) {
                return Result.error("验证码错误或已过期");
            }

            // 如果用户不存在，自动注册新用户
            if (user == null) {
                user = createNewUserByEmail(request.getEmail());
            }

            // 清除验证码
            redisTemplate.delete(CODE_PREFIX + request.getEmail());
        } else {
            return Result.error("登录类型错误");
        }

        // 返回时不包含密码
        user.setPassword(null);
        return Result.success("登录成功", user);
    }

    /**
     * 通过邮箱创建新用户（免密登录自动注册）
     */
    private User createNewUserByEmail(String email) {
        // 生成默认用户名：用户+时间戳后6位
        String defaultUsername = "用户" + System.currentTimeMillis() % 1000000;

        User user = new User();
        user.setUsername(defaultUsername);
        user.setEmail(email);
        // 设置一个随机密码（用户可以后续修改）
        String randomPassword = String.format("%08d", new Random().nextInt(100000000));
        user.setPassword(DigestUtils.md5DigestAsHex(randomPassword.getBytes()));
        user.setGender(0);
        user.setAvatar("https://api.dicebear.com/7.x/avataaars/svg?seed=" + defaultUsername);
        user.setBio("");
        user.setLevel(1);
        user.setTitle("新人");
        user.setCreateTime(LocalDateTime.now());
        user.setUpdateTime(LocalDateTime.now());

        this.save(user);

        return user;
    }

    @Override
    public Result<String> sendCode(String email) {
        if (!StringUtils.hasText(email)) {
            return Result.error("邮箱不能为空");
        }

        // 生成6位验证码
        String code = String.format("%06d", new Random().nextInt(1000000));

        // 存储验证码到Redis，5分钟过期
        redisTemplate.opsForValue().set(CODE_PREFIX + email, code, CODE_EXPIRE_TIME, TimeUnit.MINUTES);

        // 发送邮件
        try {
            mailService.sendVerificationCode(email, code);
        } catch (Exception e) {
            return Result.error("邮件发送失败：" + e.getMessage());
        }

        return Result.success("验证码已发送");
    }

    @Override
    public boolean verifyCode(String email, String code) {
        String savedCode = redisTemplate.opsForValue().get(CODE_PREFIX + email);

        if (savedCode == null) {
            return false;
        }

        return savedCode.equals(code);
    }

    @Override
    public User getByEmail(String email) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getEmail, email);
        return this.getOne(wrapper);
    }

    @Override
    public boolean isUsernameExists(String username, Long excludeUserId) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, username);
        // 如果有排除的用户ID，则排除该用户
        if (excludeUserId != null) {
            wrapper.ne(User::getId, excludeUserId);
        }
        return this.count(wrapper) > 0;
    }
}
