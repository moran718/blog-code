package com.mr.blog.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 管理端随笔评论列表VO
 */
@Data
public class AdminCommentVO {
    /**
     * 评论ID
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
     * 评论内容
     */
    private String content;

    /**
     * 图片URL列表
     */
    private String images;

    /**
     * 所属随笔/留言ID
     */
    private Long targetId;

    /**
     * 所属随笔/留言内容预览
     */
    private String targetTitle;

    /**
     * 是否为回复（二级评论）
     */
    private Boolean isReply;

    /**
     * 父评论ID
     */
    private Long parentId;

    /**
     * 被回复用户ID
     */
    private Long replyToUserId;

    /**
     * 被回复用户名
     */
    private String replyToUsername;

    /**
     * 图片URL列表（分割后的数组）
     */
    private String[] imageList;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;
}
