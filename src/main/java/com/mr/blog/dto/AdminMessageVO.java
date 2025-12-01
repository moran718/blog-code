package com.mr.blog.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 管理端留言/弹幕列表VO
 */
@Data
public class AdminMessageVO {
    /**
     * 留言ID
     */
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户名
     */
    private String username;

    /**
     * 用户头像
     */
    private String avatar;

    /**
     * 类型：0-弹幕，1-留言
     */
    private Integer type;

    /**
     * 内容
     */
    private String content;

    /**
     * 图片URL（逗号分隔）
     */
    private String images;

    /**
     * 图片URL列表
     */
    private String[] imageList;

    /**
     * 点赞数（弹幕）
     */
    private Integer likes;

    /**
     * 回复数量
     */
    private Integer replyCount;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;
}

