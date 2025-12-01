package com.mr.blog.service;

import com.mr.blog.dto.*;
import com.mr.blog.entity.RecordCategory;
import com.mr.blog.entity.RecordTag;

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

    /**
     * 获取最新文章（首页用）
     */
    List<RecordVO> getLatestRecords(int limit);

    /**
     * 获取热门文章（按浏览量排序，首页用）
     */
    List<RecordVO> getHotRecords(int limit);

    /**
     * 获取归档数据（按年月分组）
     */
    List<ArchiveVO> getArchiveList();

    // ==================== 管理端接口 ====================

    /**
     * 添加文章
     */
    Long addArticle(ArticleRequest request, Long userId);

    /**
     * 更新文章
     */
    void updateArticle(ArticleRequest request);

    /**
     * 删除文章
     */
    void deleteArticle(Long id);

    /**
     * 获取分类树（用于级联选择器）
     */
    List<RecordCategory> getCategoryTree();

    /**
     * 获取所有标签
     */
    List<RecordTag> getAllTags();

    /**
     * 获取文章的标签ID列表
     */
    List<Long> getArticleTagIds(Long articleId);
}
