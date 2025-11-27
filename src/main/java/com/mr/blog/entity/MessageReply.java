package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("message_reply")
public class MessageReply {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long messageId;
    
    private Long userId;
    
    /**
     * 父回复ID，0表示一级回复
     */
    private Long parentId;
    
    /**
     * 被回复用户ID
     */
    private Long replyToUserId;
    
    private String content;
    
    private LocalDateTime createdAt;
}

