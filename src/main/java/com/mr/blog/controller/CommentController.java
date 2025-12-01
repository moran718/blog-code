package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.AdminCommentVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.User;
import com.mr.blog.service.CommentService;
import com.mr.blog.service.UserService;
import com.mr.blog.utils.JwtUtils;
import com.mr.blog.utils.PageUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 随笔评论管理控制器
 */
@RestController
@RequestMapping("/api/comment")
@CrossOrigin
public class CommentController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtils jwtUtils;

    /**
     * 获取随笔评论列表（管理端，分页）
     */
    @GetMapping("/admin/list")
    public Result<PageVO<AdminCommentVO>> getCommentList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            HttpServletRequest request) {

        // 验证管理员权限
        if (!isAdmin(request)) {
            return Result.error(403, "无权访问");
        }

        int[] params = PageUtils.validateParams(page, size);
        PageVO<AdminCommentVO> result = commentService.getAdminCommentList(params[0], params[1], keyword);
        return Result.success(result);
    }

    /**
     * 删除随笔评论（管理端）
     */
    @DeleteMapping("/delete")
    public Result<Void> deleteComment(@RequestParam Long id, HttpServletRequest request) {
        // 验证管理员权限
        if (!isAdmin(request)) {
            return Result.error(403, "无权访问");
        }

        if (id == null) {
            return Result.error("参数错误");
        }

        try {
            commentService.deleteCommentByAdmin(id);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 验证是否为管理员
     */
    private boolean isAdmin(HttpServletRequest request) {
        String token = getTokenFromCookies(request);
        if (token == null || !jwtUtils.validateToken(token)) {
            return false;
        }
        Long userId = jwtUtils.getUserIdFromToken(token);
        User user = userService.getById(userId);
        return user != null && user.getRole() != null && user.getRole() == 1;
    }

    /**
     * 从 Cookie 中获取 Token
     */
    private String getTokenFromCookies(HttpServletRequest request) {
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
}
