package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 网站访问统计实体
 */
@Data
@TableName("site_visit")
public class SiteVisit {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 访问日期
     */
    private LocalDate visitDate;

    /**
     * 当日访问次数
     */
    private Integer visitCount;

    /**
     * 创建时间
     */
    private LocalDateTime createdAt;

    /**
     * 更新时间
     */
    private LocalDateTime updatedAt;
}

