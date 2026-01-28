package com.mr.blog.service;

import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.SensitiveWord;

import java.util.List;

public interface SensitiveWordService {

    /**
     * 分页获取敏感词列表
     */
    PageVO<SensitiveWord> getPageList(int page, int size, String keyword);

    /**
     * 获取所有启用的敏感词
     */
    List<SensitiveWord> getAllEnabled();

    /**
     * 根据ID获取敏感词
     */
    SensitiveWord getById(Long id);

    /**
     * 添加敏感词
     */
    void add(SensitiveWord sensitiveWord);

    /**
     * 更新敏感词
     */
    void update(SensitiveWord sensitiveWord);

    /**
     * 删除敏感词
     */
    void delete(Long id);

    /**
     * 批量添加敏感词
     * 
     * @param words 敏感词列表，每行一个
     */
    void batchAdd(List<String> words);

    /**
     * 切换启用状态
     */
    void toggleEnabled(Long id);

    /**
     * 过滤内容（根据当前策略）
     * 
     * @param content 原始内容
     * @return 过滤后的内容，如果策略是block且包含敏感词则抛出异常
     */
    String filterContent(String content);

    /**
     * 检查内容是否包含敏感词
     */
    boolean containsSensitiveWord(String content);

    /**
     * 查找内容中的所有敏感词
     */
    List<String> findSensitiveWords(String content);

    /**
     * 获取当前过滤策略
     * 
     * @return replace 或 block
     */
    String getStrategy();

    /**
     * 设置过滤策略
     * 
     * @param strategy replace 或 block
     */
    void setStrategy(String strategy);

    /**
     * 重新加载敏感词库
     */
    void reloadFilter();
}
