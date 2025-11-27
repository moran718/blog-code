package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.PageVO;
import com.mr.blog.dto.RecordCategoryVO;
import com.mr.blog.dto.RecordQueryRequest;
import com.mr.blog.dto.RecordVO;
import com.mr.blog.service.RecordService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 记录控制器
 */
@RestController
@RequestMapping("/api/record")
public class RecordController {
    
    @Autowired
    private RecordService recordService;
    
    /**
     * 获取记录列表（分页）
     */
    @GetMapping("/list")
    public Result<PageVO<RecordVO>> getRecordList(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String subCategory,
            @RequestParam(required = false) String tag,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "newest") String sortBy,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "6") Integer pageSize
    ) {
        RecordQueryRequest request = new RecordQueryRequest();
        request.setCategory(category);
        request.setSubCategory(subCategory);
        request.setTag(tag);
        request.setKeyword(keyword);
        request.setSortBy(sortBy);
        request.setPage(page);
        request.setPageSize(pageSize);
        
        PageVO<RecordVO> result = recordService.getRecordList(request);
        return Result.success(result);
    }
    
    /**
     * 获取记录详情
     */
    @GetMapping("/{id}")
    public Result<RecordVO> getRecordDetail(@PathVariable Long id) {
        RecordVO record = recordService.getRecordById(id);
        if (record == null) {
            return Result.error("记录不存在");
        }
        // 增加浏览量
        recordService.incrementViews(id);
        return Result.success(record);
    }
    
    /**
     * 获取分类列表
     */
    @GetMapping("/categories")
    public Result<List<RecordCategoryVO>> getCategories() {
        List<RecordCategoryVO> categories = recordService.getCategories();
        return Result.success(categories);
    }
    
    /**
     * 获取子分类映射
     */
    @GetMapping("/subcategories")
    public Result<Map<String, List<RecordCategoryVO>>> getSubCategories() {
        Map<String, List<RecordCategoryVO>> subCategoryMap = recordService.getSubCategoryMap();
        return Result.success(subCategoryMap);
    }
    
    /**
     * 获取热门标签
     */
    @GetMapping("/hot-tags")
    public Result<List<String>> getHotTags(
            @RequestParam(defaultValue = "10") Integer limit
    ) {
        List<String> tags = recordService.getHotTags(limit);
        return Result.success(tags);
    }
    
    /**
     * 点赞/取消点赞
     */
    @PostMapping("/{id}/like")
    public Result<Map<String, Object>> toggleLike(
            @PathVariable Long id,
            @RequestParam(required = false) Long userId,
            HttpServletRequest request
    ) {
        String ipAddress = getClientIp(request);
        boolean liked = recordService.toggleLike(id, userId, ipAddress);
        
        // 获取最新的点赞数
        RecordVO record = recordService.getRecordById(id);
        
        Map<String, Object> result = new HashMap<>();
        result.put("liked", liked);
        result.put("likes", record != null ? record.getLikes() : 0);
        
        return Result.success(result);
    }
    
    /**
     * 检查是否已点赞
     */
    @GetMapping("/{id}/liked")
    public Result<Boolean> checkLiked(
            @PathVariable Long id,
            @RequestParam(required = false) Long userId,
            HttpServletRequest request
    ) {
        String ipAddress = getClientIp(request);
        boolean liked = recordService.hasLiked(id, userId, ipAddress);
        return Result.success(liked);
    }
    
    /**
     * 获取客户端IP地址
     */
    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        // 多个代理的情况，取第一个IP
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }
}

