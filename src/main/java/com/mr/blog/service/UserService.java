package com.mr.blog.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.mr.blog.common.Result;
import com.mr.blog.dto.AdminUserVO;
import com.mr.blog.dto.LoginRequest;
import com.mr.blog.dto.PageVO;
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
     * 重置密码
     *
     * @param email       邮箱
     * @param code        验证码
     * @param newPassword 新密码
     * @return 结果
     */
    Result<String> resetPassword(String email, String code, String newPassword);

    /**
     * 修改密码（需验证旧密码）
     *
     * @param userId      用户ID
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 结果
     */
    Result<String> changePassword(Long userId, String oldPassword, String newPassword);

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

    /**
     * 获取管理员信息
     */
    User getAdmin();

    // ==================== 管理端方法 ====================

    /**
     * 获取用户列表（管理端，分页）
     *
     * @param page    页码
     * @param size    每页条数
     * @param keyword 关键词（搜索用户名/邮箱）
     * @param role    角色筛选（可为null）
     * @return 用户分页列表
     */
    PageVO<AdminUserVO> getAdminUserList(int page, int size, String keyword, Integer role);

    /**
     * 管理员更新用户信息
     *
     * @param userId   用户ID
     * @param username 用户名
     * @param gender   性别
     * @param bio      简介
     */
    void updateUserByAdmin(Long userId, String username, Integer gender, String bio);

    /**
     * 管理员修改用户角色
     *
     * @param userId 用户ID
     * @param role   新角色
     */
    void updateUserRole(Long userId, Integer role);

    /**
     * 管理员删除用户
     *
     * @param userId 用户ID
     */
    void deleteUserByAdmin(Long userId);
}
