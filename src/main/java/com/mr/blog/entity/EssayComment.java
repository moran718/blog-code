package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("essay_comment")
public class EssayComment {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long essayId;
    
    private Long userId;
    
    /**
     * 父评论ID，0表示一级评论
     */
    private Long parentId;
    
    /**
     * 被回复用户ID，用于三级回复显示@用户名
     */
    private Long replyToUserId;
    
    private String content;
    
    /**
     * 图片URL，多张用逗号分隔
     */
    private String images;
    
    private LocalDateTime createdAt;
}

