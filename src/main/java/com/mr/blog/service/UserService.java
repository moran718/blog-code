package com.mr.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mr.blog.common.Result;
import com.mr.blog.dto.LoginRequest;
import com.mr.blog.dto.RegisterRequest;
import com.mr.blog.entity.User;

public interface UserService extends IService<User> {

    /**
     * 用户注册
     */
    Result<User> register(RegisterRequest request);

    /**
     * 用户登录
     */
    Result<User> login(LoginRequest request);

    /**
     * 发送验证码
     */
    Result<String> sendCode(String email);

    /**
     * 验证验证码
     */
    boolean verifyCode(String email, String code);

    /**
     * 根据邮箱获取用户
     */
    User getByEmail(String email);

    /**
     * 检查用户名是否已存在（排除指定用户ID）
     * 
     * @param username      用户名
     * @param excludeUserId 排除的用户ID（可为null）
     * @return true-已存在，false-不存在
     */
    boolean isUsernameExists(String username, Long excludeUserId);
}
