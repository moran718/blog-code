package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.service.AiReplyService;
import com.mr.blog.utils.JwtUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * AI 配置管理接口（管理端）
 */
@RestController
@RequestMapping("/api/admin/ai")
@CrossOrigin
public class AiConfigController {

    @Autowired
    private AiReplyService aiReplyService;

    @Autowired
    private JwtUtils jwtUtils;

    /**
     * 获取 AI 配置
     */
    @GetMapping("/config")
    public Result<Map<String, Object>> getAiConfig(HttpServletRequest request) {
        Long userId = getCurrentUserId(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        Map<String, Object> config = new HashMap<>();
        config.put("aiReplyEnabled", aiReplyService.isAiReplyEnabled());
        return Result.success(config);
    }

    /**
     * 更新 AI 配置
     */
    @PutMapping("/config")
    public Result<Void> updateAiConfig(@RequestBody Map<String, Object> configMap, HttpServletRequest request) {
        Long userId = getCurrentUserId(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        Boolean enabled = (Boolean) configMap.get("aiReplyEnabled");
        if (enabled != null) {
            aiReplyService.setAiReplyEnabled(enabled);
        }

        return Result.success();
    }

    private Long getCurrentUserId(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    String token = cookie.getValue();
                    if (jwtUtils.validateToken(token)) {
                        return jwtUtils.getUserIdFromToken(token);
                    }
                }
            }
        }
        return null;
    }
}
