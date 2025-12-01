package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.mr.blog.common.Result;
import com.mr.blog.dto.AdminUserVO;
import com.mr.blog.dto.LoginRequest;
import com.mr.blog.dto.PageVO;
import com.mr.blog.dto.RegisterRequest;
import com.mr.blog.entity.Essay;
import com.mr.blog.entity.EssayComment;
import com.mr.blog.entity.Level;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.EssayCommentMapper;
import com.mr.blog.mapper.EssayMapper;
import com.mr.blog.mapper.LevelMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.MailService;
import com.mr.blog.service.UserService;
import com.mr.blog.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private MailService mailService;

    @Autowired
    private LevelMapper levelMapper;

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
        user.setExp(0);
        user.setLevelId(1);
        user.setRole(0); // 默认普通用户
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
        user.setExp(0);
        user.setLevelId(1);
        user.setRole(0); // 默认普通用户
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
    public Result<String> resetPassword(String email, String code, String newPassword) {
        if (!StringUtils.hasText(email)) {
            return Result.error("邮箱不能为空");
        }
        if (!StringUtils.hasText(code)) {
            return Result.error("验证码不能为空");
        }
        if (!StringUtils.hasText(newPassword)) {
            return Result.error("新密码不能为空");
        }
        if (newPassword.length() < 6) {
            return Result.error("密码长度不能少于6位");
        }

        // 验证验证码
        if (!verifyCode(email, code)) {
            return Result.error("验证码错误或已过期");
        }

        // 查找用户
        User user = getByEmail(email);
        if (user == null) {
            return Result.error("该邮箱未注册");
        }

        // 更新密码
        user.setPassword(DigestUtils.md5DigestAsHex(newPassword.getBytes()));
        user.setUpdateTime(LocalDateTime.now());
        this.updateById(user);

        // 清除验证码
        redisTemplate.delete(CODE_PREFIX + email);

        return Result.success("密码重置成功");
    }

    @Override
    public Result<String> changePassword(Long userId, String oldPassword, String newPassword) {
        if (userId == null) {
            return Result.error("用户ID不能为空");
        }
        if (!StringUtils.hasText(oldPassword)) {
            return Result.error("旧密码不能为空");
        }
        if (!StringUtils.hasText(newPassword)) {
            return Result.error("新密码不能为空");
        }
        if (newPassword.length() < 6) {
            return Result.error("新密码长度不能少于6位");
        }

        // 查找用户
        User user = this.getById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }

        // 验证旧密码
        String encryptedOldPassword = DigestUtils.md5DigestAsHex(oldPassword.getBytes());
        if (!encryptedOldPassword.equals(user.getPassword())) {
            return Result.error("旧密码错误");
        }

        // 更新密码
        user.setPassword(DigestUtils.md5DigestAsHex(newPassword.getBytes()));
        user.setUpdateTime(LocalDateTime.now());
        this.updateById(user);

        return Result.success("密码修改成功");
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

    @Override
    public User getAdmin() {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getRole, 1); // 角色为管理员
        wrapper.last("LIMIT 1");
        return this.getOne(wrapper);
    }

    // ==================== 管理端方法实现 ====================

    @Autowired
    private EssayMapper essayMapper;

    @Autowired
    private EssayCommentMapper essayCommentMapper;

    @Override
    public PageVO<AdminUserVO> getAdminUserList(int page, int size, String keyword, Integer role) {
        // 构建查询条件
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.and(w -> w.like(User::getUsername, keyword)
                    .or().like(User::getEmail, keyword));
        }
        if (role != null) {
            wrapper.eq(User::getRole, role);
        }
        wrapper.orderByDesc(User::getCreateTime);

        // 分页查询
        Page<User> pageParam = PageUtils.createPage(page, size);
        Page<User> userPage = this.page(pageParam, wrapper);
        List<User> users = userPage.getRecords();

        if (users.isEmpty()) {
            return PageUtils.toPageVO(userPage, new ArrayList<>());
        }

        // 获取用户ID列表
        List<Long> userIds = users.stream().map(User::getId).collect(Collectors.toList());

        // 统计每个用户的随笔数量
        Map<Long, Long> essayCountMap = new HashMap<>();
        LambdaQueryWrapper<Essay> essayWrapper = new LambdaQueryWrapper<>();
        essayWrapper.in(Essay::getUserId, userIds);
        List<Essay> essays = essayMapper.selectList(essayWrapper);
        for (Essay essay : essays) {
            essayCountMap.merge(essay.getUserId(), 1L, Long::sum);
        }

        // 统计每个用户的评论数量
        Map<Long, Long> commentCountMap = new HashMap<>();
        LambdaQueryWrapper<EssayComment> commentWrapper = new LambdaQueryWrapper<>();
        commentWrapper.in(EssayComment::getUserId, userIds);
        List<EssayComment> comments = essayCommentMapper.selectList(commentWrapper);
        for (EssayComment comment : comments) {
            commentCountMap.merge(comment.getUserId(), 1L, Long::sum);
        }

        // 获取所有等级信息，构建等级ID到等级对象的映射
        List<Level> levels = levelMapper.selectList(null);
        Map<Integer, Level> levelMap = new HashMap<>();
        for (Level level : levels) {
            levelMap.put(level.getId(), level);
        }

        // 转换为VO
        List<AdminUserVO> result = new ArrayList<>();
        for (User user : users) {
            AdminUserVO vo = new AdminUserVO();
            vo.setId(user.getId());
            vo.setUsername(user.getUsername());
            vo.setEmail(user.getEmail());
            vo.setGender(user.getGender());
            vo.setAvatar(user.getAvatar());
            vo.setBio(user.getBio());
            int levelId = user.getLevelId() != null ? user.getLevelId() : 1;
            vo.setLevel(levelId);
            // 从等级表获取等级名称作为称号
            Level level = levelMap.get(levelId);
            vo.setTitle(level != null ? level.getName() : "初来乍到");
            vo.setExp(user.getExp() != null ? user.getExp() : 0);
            vo.setRole(user.getRole());
            vo.setEssayCount(essayCountMap.getOrDefault(user.getId(), 0L).intValue());
            vo.setCommentCount(commentCountMap.getOrDefault(user.getId(), 0L).intValue());
            vo.setCreatedAt(user.getCreateTime());
            result.add(vo);
        }

        return PageUtils.toPageVO(userPage, result);
    }

    @Override
    @Transactional
    public void updateUserByAdmin(Long userId, String username, Integer gender, String bio) {
        User user = this.getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        // 检查用户名是否被其他用户占用
        if (StringUtils.hasText(username) && !username.equals(user.getUsername())) {
            if (isUsernameExists(username, userId)) {
                throw new RuntimeException("用户名已被其他用户使用");
            }
            user.setUsername(username);
        }

        if (gender != null) {
            user.setGender(gender);
        }
        if (bio != null) {
            user.setBio(bio);
        }
        user.setUpdateTime(LocalDateTime.now());

        this.updateById(user);
    }

    @Override
    @Transactional
    public void updateUserRole(Long userId, Integer role) {
        User user = this.getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        user.setRole(role);
        user.setUpdateTime(LocalDateTime.now());
        this.updateById(user);
    }

    @Override
    @Transactional
    public void deleteUserByAdmin(Long userId) {
        User user = this.getById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        // 不能删除管理员
        if (user.getRole() == 1) {
            throw new RuntimeException("不能删除管理员账户");
        }

        // 删除用户（可以根据业务需求决定是否级联删除用户的随笔和评论）
        this.removeById(userId);
    }
}
