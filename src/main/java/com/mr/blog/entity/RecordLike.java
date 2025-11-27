package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 记录点赞实体类
 */
@Data
@TableName("record_like")
public class RecordLike {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long recordId;
    
    private Long userId;
    
    private String ipAddress;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}

