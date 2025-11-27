package com.mr.blog.service;

import com.mr.blog.dto.PageVO;
import com.mr.blog.dto.RecordCategoryVO;
import com.mr.blog.dto.RecordQueryRequest;
import com.mr.blog.dto.RecordVO;

import java.util.List;
import java.util.Map;

/**
 * 记录服务接口
 */
public interface RecordService {
    
    /**
     * 分页查询记录
     */
    PageVO<RecordVO> getRecordList(RecordQueryRequest request);
    
    /**
     * 根据ID获取记录详情
     */
    RecordVO getRecordById(Long id);
    
    /**
     * 增加浏览量
     */
    void incrementViews(Long id);
    
    /**
     * 点赞/取消点赞
     */
    boolean toggleLike(Long recordId, Long userId, String ipAddress);
    
    /**
     * 检查是否已点赞
     */
    boolean hasLiked(Long recordId, Long userId, String ipAddress);
    
    /**
     * 获取所有分类（包含子分类和记录数量）
     */
    List<RecordCategoryVO> getCategories();
    
    /**
     * 获取子分类映射（key: 一级分类key, value: 子分类列表）
     */
    Map<String, List<RecordCategoryVO>> getSubCategoryMap();
    
    /**
     * 获取热门标签
     */
    List<String> getHotTags(int limit);
    
    /**
     * 获取所有记录数量
     */
    int getTotalCount();
}

