package com.mr.blog.dto;

import lombok.Data;

/**
 * 分类请求DTO
 */
@Data
public class CategoryRequest {
    
    /**
     * 分类ID（编辑时需要）
     */
    private Long id;
    
    /**
     * 分类名称
     */
    private String name;
    
    /**
     * 分类key（英文标识）
     */
    private String categoryKey;
    
    /**
     * 图标
     */
    private String icon;
    
    /**
     * 父分类ID
     */
    private Long parentId;
    
    /**
     * 排序
     */
    private Integer sort;
}

