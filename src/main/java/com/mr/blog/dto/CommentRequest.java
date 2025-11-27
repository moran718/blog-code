package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 发表评论请求
 */
@Data
public class CommentRequest {
    private Long essayId;
    private Long parentId;          // 父评论ID，0表示一级评论
    private Long replyToUserId;     // 被回复用户ID，仅三级回复需要
    private String content;
    private List<String> images;
}

