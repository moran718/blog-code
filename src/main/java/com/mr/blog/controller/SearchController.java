package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.SearchResultVO;
import com.mr.blog.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 全站搜索控制器
 */
@RestController
@RequestMapping("/api/search")
@CrossOrigin
public class SearchController {

    @Autowired
    private SearchService searchService;

    /**
     * 全站搜索
     * @param keyword 关键词
     * @param type 类型：all-全部, record-文章, essay-随笔, music-音乐
     * @param limit 每类返回数量限制
     */
    @GetMapping
    public Result<SearchResultVO> search(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "all") String type,
            @RequestParam(defaultValue = "5") Integer limit) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Result.error("请输入搜索关键词");
        }
        SearchResultVO result = searchService.search(keyword.trim(), type, limit);
        return Result.success(result);
    }
}

