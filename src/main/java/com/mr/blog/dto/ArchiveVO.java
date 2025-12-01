package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 归档视图对象 - 年份级别
 */
@Data
public class ArchiveVO {
    
    /**
     * 年份
     */
    private Integer year;
    
    /**
     * 该年份的文章总数
     */
    private Integer count;
    
    /**
     * 该年份下的月份列表
     */
    private List<ArchiveMonthVO> months;
    
    /**
     * 归档视图对象 - 月份级别
     */
    @Data
    public static class ArchiveMonthVO {
        
        /**
         * 月份
         */
        private Integer month;
        
        /**
         * 该月份的文章数量
         */
        private Integer count;
        
        /**
         * 该月份的文章列表
         */
        private List<ArchiveRecordVO> records;
    }
    
    /**
     * 归档视图对象 - 文章级别（简化版）
     */
    @Data
    public static class ArchiveRecordVO {
        
        /**
         * 文章ID
         */
        private Long id;
        
        /**
         * 文章标题
         */
        private String title;
        
        /**
         * 封面图
         */
        private String cover;
        
        /**
         * 发布日期（格式：MM-dd）
         */
        private String date;
        
        /**
         * 分类名称
         */
        private String categoryName;
        
        /**
         * 浏览量
         */
        private Integer views;
        
        /**
         * 点赞数
         */
        private Integer likes;
    }
}

