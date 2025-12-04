package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 浏览记录实体
 */
@Data
@TableName("browse_log")
public class BrowseLog {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 访问IP地址
     */
    private String ip;

    /**
     * 访问的URL
     */
    private String url;

    /**
     * 浏览器User-Agent
     */
    private String userAgent;

    /**
     * 来源页面
     */
    private String referer;

    /**
     * 访问时间
     */
    private LocalDateTime createdAt;
}

