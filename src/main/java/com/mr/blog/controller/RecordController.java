package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.*;
import com.mr.blog.entity.RecordCategory;
import com.mr.blog.entity.RecordTag;
import com.mr.blog.service.RecordService;
import com.mr.blog.utils.JwtUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * 记录控制器
 */
@RestController
@RequestMapping("/api/record")
@CrossOrigin
public class RecordController {

    @Autowired
    private RecordService recordService;

    @Autowired
    private JwtUtils jwtUtils;

    @Value("${FILE_UPLOAD_PATH:${file.upload-path:uploads/}}")
    private String uploadPath;

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
            @RequestParam(defaultValue = "6") Integer pageSize) {
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
            @RequestParam(defaultValue = "10") Integer limit) {
        List<String> tags = recordService.getHotTags(limit);
        return Result.success(tags);
    }

    /**
     * 获取最新文章（首页用）
     */
    @GetMapping("/latest")
    public Result<List<RecordVO>> getLatestRecords(
            @RequestParam(defaultValue = "9") Integer limit) {
        List<RecordVO> records = recordService.getLatestRecords(limit);
        return Result.success(records);
    }

    /**
     * 获取热门文章（首页用，按浏览量排序）
     */
    @GetMapping("/hot")
    public Result<List<RecordVO>> getHotRecords(
            @RequestParam(defaultValue = "5") Integer limit) {
        List<RecordVO> records = recordService.getHotRecords(limit);
        return Result.success(records);
    }

    /**
     * 获取归档数据（按年月分组）
     */
    @GetMapping("/archive")
    public Result<List<ArchiveVO>> getArchiveList() {
        List<ArchiveVO> archiveList = recordService.getArchiveList();
        return Result.success(archiveList);
    }

    /**
     * 点赞/取消点赞
     */
    @PostMapping("/{id}/like")
    public Result<Map<String, Object>> toggleLike(
            @PathVariable Long id,
            @RequestParam(required = false) Long userId,
            HttpServletRequest request) {
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
            HttpServletRequest request) {
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

    // ==================== 管理端接口 ====================

    /**
     * 添加文章
     */
    @PostMapping("/add")
    public Result<Long> addArticle(@RequestBody ArticleRequest request, HttpServletRequest httpRequest) {
        Long userId = getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error("请先登录");
        }
        Long id = recordService.addArticle(request, userId);
        return Result.success(id);
    }

    /**
     * 更新文章
     */
    @PutMapping("/update")
    public Result<Void> updateArticle(@RequestBody ArticleRequest request, HttpServletRequest httpRequest) {
        Long userId = getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error("请先登录");
        }
        recordService.updateArticle(request);
        return Result.success(null);
    }

    /**
     * 删除文章
     */
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteArticle(@PathVariable Long id, HttpServletRequest httpRequest) {
        Long userId = getUserIdFromToken(httpRequest);
        if (userId == null) {
            return Result.error("请先登录");
        }
        recordService.deleteArticle(id);
        return Result.success(null);
    }

    /**
     * 获取分类树（用于级联选择器）
     */
    @GetMapping("/category-tree")
    public Result<List<RecordCategory>> getCategoryTree() {
        List<RecordCategory> tree = recordService.getCategoryTree();
        return Result.success(tree);
    }

    /**
     * 获取所有标签
     */
    @GetMapping("/tags")
    public Result<List<RecordTag>> getAllTags() {
        List<RecordTag> tags = recordService.getAllTags();
        return Result.success(tags);
    }

    /**
     * 获取文章的标签ID列表
     */
    @GetMapping("/{id}/tag-ids")
    public Result<List<Long>> getArticleTagIds(@PathVariable Long id) {
        List<Long> tagIds = recordService.getArticleTagIds(id);
        return Result.success(tagIds);
    }

    /**
     * 上传文章封面
     */
    @PostMapping("/uploadCover")
    public Result<String> uploadCover(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件不能为空");
        }

        // 验证文件类型
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return Result.error("只能上传图片文件");
        }

        // 验证文件大小（最大5MB）
        if (file.getSize() > 5 * 1024 * 1024) {
            return Result.error("图片大小不能超过5MB");
        }

        try {
            // 生成文件名
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + extension;

            // 保存文件
            String coverPath = uploadPath + "records/covers/";
            File dir = new File(coverPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File destFile = new File(coverPath + newFilename);
            file.transferTo(destFile);

            // 返回相对路径
            String imageUrl = "/uploads/records/covers/" + newFilename;
            return Result.success(imageUrl);
        } catch (IOException e) {
            return Result.error("上传失败: " + e.getMessage());
        }
    }

    /**
     * 从Token中获取用户ID
     */
    private Long getUserIdFromToken(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    String token = cookie.getValue();
                    return jwtUtils.getUserIdFromToken(token);
                }
            }
        }
        return null;
    }
}
