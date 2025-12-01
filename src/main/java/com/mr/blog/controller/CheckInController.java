package com.mr.blog.controller;

import com.mr.blog.dto.CheckInVO;
import com.mr.blog.common.Result;
import com.mr.blog.service.CheckInService;
import com.mr.blog.utils.JwtUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/checkin")
@CrossOrigin(origins = { "http://localhost:5173", "http://localhost:5174" }, allowCredentials = "true")
public class CheckInController {

    @Autowired
    private CheckInService checkInService;

    @Autowired
    private JwtUtils jwtUtils;

    /**
     * 获取签到状态
     */
    @GetMapping("/status")
    public Result<CheckInVO> getCheckInStatus(HttpServletRequest request) {
        Long userId = getCurrentUserId(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        try {
            CheckInVO vo = checkInService.getCheckInStatus(userId);
            return Result.success(vo);
        } catch (Exception e) {
            return Result.error("获取签到状态失败: " + e.getMessage());
        }
    }

    /**
     * 签到
     */
    @PostMapping("/do")
    public Result<CheckInVO> checkIn(HttpServletRequest request) {
        Long userId = getCurrentUserId(request);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        try {
            CheckInVO vo = checkInService.checkIn(userId);
            return Result.success(vo);
        } catch (Exception e) {
            return Result.error("签到失败: " + e.getMessage());
        }
    }

    /**
     * 从Cookie获取当前用户ID
     */
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
