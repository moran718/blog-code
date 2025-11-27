package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 记录实体类
 */
@Data
@TableName("record")
public class Record {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String title;
    
    private String summary;
    
    private String content;
    
    private String cover;
    
    private Long categoryId;
    
    private Long userId;
    
    private Integer views;
    
    private Integer likes;
    
    private Integer status;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
}

