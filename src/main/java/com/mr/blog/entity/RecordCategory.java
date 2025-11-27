package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 记录分类实体类
 */
@Data
@TableName("record_category")
public class RecordCategory {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private String name;
    
    private String categoryKey;
    
    private String icon;
    
    private Long parentId;
    
    private Integer sortOrder;
    
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
}

