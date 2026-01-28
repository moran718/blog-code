package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("sensitive_word")
public class SensitiveWord {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 敏感词
     */
    private String word;

    /**
     * 替换文本
     */
    private String replacement;

    /**
     * 是否启用：0-禁用 1-启用
     */
    private Integer enabled;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
