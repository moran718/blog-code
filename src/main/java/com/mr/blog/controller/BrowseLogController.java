package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.BrowseLog;
import com.mr.blog.entity.User;
import com.mr.blog.service.BrowseLogService;
import com.mr.blog.service.UserService;
import com.mr.blog.utils.JwtUtils;
import com.mr.blog.utils.PageUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 浏览记录控制器
 */
@RestController
@RequestMapping("/api/browse")
@CrossOrigin
public class BrowseLogController {

    @Autowired
    private BrowseLogService browseLogService;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtils jwtUtils;

    /**
     * 记录浏览（用户端调用）
     */
    @PostMapping("/record")
    public Result<Void> recordBrowse(HttpServletRequest request) {
        String ip = getClientIp(request);
        String url = request.getHeader("Referer");
        String userAgent = request.getHeader("User-Agent");
        String referer = request.getHeader("Origin");

        browseLogService.recordBrowse(ip, url, userAgent, referer);
        return Result.success();
    }

    /**
     * 获取浏览记录列表（管理端）
     */
    @GetMapping("/admin/list")
    public Result<PageVO<BrowseLog>> getList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String ip,
            HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        int[] params = PageUtils.validateParams(page, size);
        PageVO<BrowseLog> result = browseLogService.getList(params[0], params[1], ip);
        return Result.success(result);
    }

    /**
     * 获取统计数据（管理端）
     */
    @GetMapping("/admin/stats")
    public Result<Map<String, Object>> getStats(HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        Map<String, Object> stats = new HashMap<>();
        stats.put("total", browseLogService.getTotalCount());
        stats.put("today", browseLogService.getTodayCount());
        return Result.success(stats);
    }

    /**
     * 删除单条浏览记录（管理端）
     */
    @DeleteMapping("/admin/delete")
    public Result<String> delete(@RequestParam Long id, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        browseLogService.deleteById(id);
        return Result.success("删除成功");
    }

    /**
     * 清空所有浏览记录（管理端）
     */
    @DeleteMapping("/admin/clear")
    public Result<String> clearAll(HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        browseLogService.clearAll();
        return Result.success("清空成功");
    }

    /**
     * 获取客户端真实IP
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
        // 如果是多级代理，取第一个IP
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        // 处理IPv6本地回环地址，转换为IPv4格式
        if ("0:0:0:0:0:0:0:1".equals(ip) || "::1".equals(ip)) {
            ip = "127.0.0.1";
        }
        return ip;
    }

    /**
     * 从请求中获取 Token
     */
    private String getTokenFromRequest(HttpServletRequest request) {
        // 优先从 Authorization Header 获取
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }

        // 其次从 Cookie 中获取
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * 检查是否是管理员
     */
    private boolean isAdmin(HttpServletRequest request) {
        String token = getTokenFromRequest(request);
        if (token == null || !jwtUtils.validateToken(token)) {
            return false;
        }
        Long userId = jwtUtils.getUserIdFromToken(token);
        User user = userService.getById(userId);
        return user != null && user.getRole() == 1;
    }
}
