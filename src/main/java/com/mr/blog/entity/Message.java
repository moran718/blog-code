package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("message")
public class Message {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long userId;
    
    /**
     * 类型：0-弹幕，1-留言
     */
    private Integer type;
    
    private String content;
    
    /**
     * 图片URL，多张用逗号分隔（仅留言有）
     */
    private String images;
    
    /**
     * 点赞数（仅弹幕有）
     */
    private Integer likes;
    
    private LocalDateTime createdAt;
}

