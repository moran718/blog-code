package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 记录-标签关联实体类
 */
@Data
@TableName("record_tag_relation")
public class RecordTagRelation {
    
    @TableId(type = IdType.AUTO)
    private Long id;
    
    private Long recordId;
    
    private Long tagId;
}

