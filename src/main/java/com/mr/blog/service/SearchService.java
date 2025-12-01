package com.mr.blog.service;

import com.mr.blog.dto.SearchResultVO;

/**
 * 全站搜索服务接口
 */
public interface SearchService {

    /**
     * 全站搜索
     * @param keyword 关键词
     * @param type 类型：all-全部, record-文章, essay-随笔, music-音乐
     * @param limit 每类返回数量限制
     * @return 搜索结果
     */
    SearchResultVO search(String keyword, String type, int limit);
}

