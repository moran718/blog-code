package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 文章请求DTO
 */
@Data
public class ArticleRequest {
    
    /**
     * 文章ID（编辑时需要）
     */
    private Long id;
    
    /**
     * 文章标题
     */
    private String title;
    
    /**
     * 文章摘要
     */
    private String summary;
    
    /**
     * 文章内容
     */
    private String content;
    
    /**
     * 封面图片
     */
    private String cover;
    
    /**
     * 分类ID
     */
    private Long categoryId;
    
    /**
     * 标签ID列表
     */
    private List<Long> tagIds;
    
    /**
     * 状态：0-草稿，1-发布
     */
    private Integer status;
}

