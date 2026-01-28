package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.SensitiveWord;
import com.mr.blog.service.SensitiveWordService;
import com.mr.blog.utils.JwtUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/sensitive-word")
@CrossOrigin
public class SensitiveWordController {

    @Autowired
    private SensitiveWordService sensitiveWordService;

    @Autowired
    private JwtUtils jwtUtils;

    /**
     * 分页获取敏感词列表
     */
    @GetMapping("/list")
    public Result<PageVO<SensitiveWord>> getList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        PageVO<SensitiveWord> result = sensitiveWordService.getPageList(page, size, keyword);
        return Result.success(result);
    }

    /**
     * 添加敏感词
     */
    @PostMapping
    public Result<Void> add(@RequestBody SensitiveWord sensitiveWord, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        if (sensitiveWord.getWord() == null || sensitiveWord.getWord().trim().isEmpty()) {
            return Result.error("敏感词不能为空");
        }
        try {
            sensitiveWordService.add(sensitiveWord);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 更新敏感词
     */
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Long id, @RequestBody SensitiveWord sensitiveWord,
            HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        if (sensitiveWord.getWord() == null || sensitiveWord.getWord().trim().isEmpty()) {
            return Result.error("敏感词不能为空");
        }
        try {
            sensitiveWord.setId(id);
            sensitiveWordService.update(sensitiveWord);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 删除敏感词
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        sensitiveWordService.delete(id);
        return Result.success();
    }

    /**
     * 批量添加敏感词
     */
    @PostMapping("/batch")
    public Result<Void> batchAdd(@RequestBody Map<String, List<String>> body, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        List<String> words = body.get("words");
        if (words == null || words.isEmpty()) {
            return Result.error("敏感词列表不能为空");
        }
        sensitiveWordService.batchAdd(words);
        return Result.success();
    }

    /**
     * 切换启用状态
     */
    @PostMapping("/{id}/toggle")
    public Result<Void> toggleEnabled(@PathVariable Long id, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        try {
            sensitiveWordService.toggleEnabled(id);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 获取当前策略
     */
    @GetMapping("/strategy")
    public Result<String> getStrategy(HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        return Result.success(sensitiveWordService.getStrategy());
    }

    /**
     * 设置策略
     */
    @PutMapping("/strategy")
    public Result<Void> setStrategy(@RequestBody Map<String, String> body, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        String strategy = body.get("strategy");
        if (strategy == null || strategy.isEmpty()) {
            return Result.error("策略不能为空");
        }
        try {
            sensitiveWordService.setStrategy(strategy);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 测试过滤效果
     */
    @PostMapping("/test")
    public Result<Map<String, Object>> testFilter(@RequestBody Map<String, String> body, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(401, "无权限访问");
        }
        String content = body.get("content");
        if (content == null) {
            return Result.error("内容不能为空");
        }

        List<String> foundWords = sensitiveWordService.findSensitiveWords(content);
        String filtered = "";
        try {
            filtered = sensitiveWordService.filterContent(content);
        } catch (RuntimeException e) {
            filtered = "【内容被禁止】" + e.getMessage();
        }

        return Result.success(Map.of(
                "original", content,
                "filtered", filtered,
                "foundWords", foundWords,
                "strategy", sensitiveWordService.getStrategy()));
    }

    private boolean isAdmin(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    String token = cookie.getValue();
                    if (jwtUtils.validateToken(token)) {
                        // 这里可以进一步验证是否是管理员
                        return true;
                    }
                }
            }
        }
        return false;
    }
}
