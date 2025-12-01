package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 音乐实体类
 */
@Data
@TableName("music")
public class Music {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 歌曲名称
     */
    private String name;

    /**
     * 歌手/艺术家
     */
    private String artist;

    /**
     * 专辑名称
     */
    private String album;

    /**
     * 封面图片URL
     */
    private String cover;

    /**
     * 音乐文件URL
     */
    private String url;

    /**
     * 时长（秒）
     */
    private Integer duration;

    /**
     * 排序顺序
     */
    private Integer sortOrder;

    /**
     * 状态：0-禁用，1-启用
     */
    private Integer status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}

