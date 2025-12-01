package com.mr.blog.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 管理端用户列表VO
 */
@Data
public class AdminUserVO {
    /**
     * 用户ID
     */
    private Long id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 性别：0-未知，1-男，2-女
     */
    private Integer gender;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 简介
     */
    private String bio;

    /**
     * 用户等级
     */
    private Integer level;

    /**
     * 用户称号（等级名称）
     */
    private String title;

    /**
     * 经验值
     */
    private Integer exp;

    /**
     * 角色：0-普通用户，1-管理员
     */
    private Integer role;

    /**
     * 随笔数量
     */
    private Integer essayCount;

    /**
     * 评论数量
     */
    private Integer commentCount;

    /**
     * 注册时间
     */
    private LocalDateTime createdAt;
}
