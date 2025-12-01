package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 分类树形结构VO
 */
@Data
public class CategoryTreeVO {
    
    private Long id;
    
    private String name;
    
    private String categoryKey;
    
    private String icon;
    
    private Long parentId;
    
    private Integer sortOrder;
    
    /**
     * 文章数量
     */
    private Integer articleCount;
    
    /**
     * 子分类
     */
    private List<CategoryTreeVO> children;
}

