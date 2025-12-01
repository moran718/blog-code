package com.mr.blog.dto;

import lombok.Data;

/**
 * 音乐VO
 */
@Data
public class MusicVO {

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
     * 时长（格式化后的字符串，如 "3:45"）
     */
    private String duration;

    /**
     * 时长（秒）
     */
    private Integer durationSeconds;
}

