package com.mr.blog.dto;

import lombok.Data;

/**
 * 留言回复请求
 */
@Data
public class MessageReplyRequest {
    private Long messageId;
    private Long parentId;
    private Long replyToUserId;
    private String content;
}

