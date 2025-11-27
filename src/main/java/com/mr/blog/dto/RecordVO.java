package com.mr.blog.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 记录视图对象
 */
@Data
public class RecordVO {
    
    private Long id;
    
    private String title;
    
    private String summary;
    
    private String content;
    
    private String cover;
    
    private Long categoryId;
    
    /**
     * 一级分类key（如 tech, life）
     */
    private String category;
    
    /**
     * 二级分类key（如 frontend, backend）
     */
    private String subCategory;
    
    /**
     * 分类名称（二级分类的名称，如"前端开发"）
     */
    private String categoryName;
    
    /**
     * 一级分类名称
     */
    private String parentCategoryName;
    
    private Long userId;
    
    private String userName;
    
    private Integer views;
    
    private Integer likes;
    
    private Integer status;
    
    /**
     * 标签列表
     */
    private List<String> tags;
    
    /**
     * 创建日期（格式化后）
     */
    private String date;
    
    private LocalDateTime createdAt;
    
    private LocalDateTime updatedAt;
}

