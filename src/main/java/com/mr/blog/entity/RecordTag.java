package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 标签实体类
 */
@Data
@TableName("record_tag")
public class RecordTag {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String name;

    /**
     * 标签颜色
     */
    private String color;

    private Integer useCount;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
}
