package com.mr.blog.dto;

import lombok.Data;

/**
 * 记录查询请求
 */
@Data
public class RecordQueryRequest {
    
    /**
     * 一级分类key（如 tech, life）
     */
    private String category;
    
    /**
     * 二级分类key（如 frontend, backend）
     */
    private String subCategory;
    
    /**
     * 标签名称
     */
    private String tag;
    
    /**
     * 排序方式：newest（最新）, oldest（最早）, views（浏览量）, likes（点赞数）
     */
    private String sortBy = "newest";
    
    /**
     * 当前页码
     */
    private Integer page = 1;
    
    /**
     * 每页数量
     */
    private Integer pageSize = 6;
    
    /**
     * 关键词搜索
     */
    private String keyword;
}

