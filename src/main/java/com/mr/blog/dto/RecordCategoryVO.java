package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 分类视图对象
 */
@Data
public class RecordCategoryVO {
    
    private Long id;
    
    /**
     * 分类标识（如 tech, life, frontend）
     */
    private String key;
    
    /**
     * 分类名称
     */
    private String name;
    
    /**
     * 分类图标（emoji）
     */
    private String icon;
    
    /**
     * 父分类ID
     */
    private Long parentId;
    
    /**
     * 该分类下的记录数量
     */
    private Integer count;
    
    /**
     * 子分类列表
     */
    private List<RecordCategoryVO> children;
}

