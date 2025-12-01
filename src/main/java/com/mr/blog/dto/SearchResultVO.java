package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 搜索结果VO
 */
@Data
public class SearchResultVO {

    /**
     * 文章结果
     */
    private List<RecordItem> records;

    /**
     * 随笔结果
     */
    private List<EssayItem> essays;

    /**
     * 音乐结果
     */
    private List<MusicItem> musics;

    /**
     * 总数
     */
    private int total;

    @Data
    public static class RecordItem {
        private Long id;
        private String title;
        private String summary;
        private String cover;
        private String date;
        private Integer views;
    }

    @Data
    public static class EssayItem {
        private Long id;
        private String content;
        private String userName;
        private String userAvatar;
        private String date;
    }

    @Data
    public static class MusicItem {
        private Long id;
        private String name;
        private String artist;
        private String album;
        private String cover;
    }
}

