package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.AdminUserVO;
import com.mr.blog.dto.LoginRequest;
import com.mr.blog.dto.PageVO;
import com.mr.blog.dto.RegisterRequest;
import com.mr.blog.entity.User;
import com.mr.blog.service.UserService;
import com.mr.blog.utils.JwtUtils;
import com.mr.blog.utils.PageUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/user")
@CrossOrigin
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtils jwtUtils;

    @Value("${file.upload-path:uploads/}")
    private String uploadPath;

    /**
     * 用户注册
     */
    @PostMapping("/register")
    public Result<User> register(@RequestBody RegisterRequest request) {
        return userService.register(request);
    }

    /**
     * 用户登录
     */
    @PostMapping("/login")
    public Result<User> login(@RequestBody LoginRequest request, HttpServletResponse response) {
        Result<User> result = userService.login(request);

        if (result.getCode() == 200 && result.getData() != null) {
            User user = result.getData();
            // 生成 JWT Token
            String token = jwtUtils.generateToken(user.getId(), user.getEmail());

            // 设置 HttpOnly Cookie
            Cookie cookie = new Cookie("token", token);
            cookie.setHttpOnly(true); // 防止 XSS 攻击
            cookie.setPath("/");
            cookie.setMaxAge(jwtUtils.getExpirationSeconds()); // 7天过期
            // cookie.setSecure(true); // 生产环境启用，仅 HTTPS 传输
            response.addCookie(cookie);
        }

        return result;
    }

    /**
     * 用户登出
     */
    @PostMapping("/logout")
    public Result<String> logout(HttpServletResponse response) {
        // 清除 Cookie
        Cookie cookie = new Cookie("token", null);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(0); // 立即过期
        response.addCookie(cookie);

        return Result.success("登出成功");
    }

    /**
     * 获取当前登录用户信息
     */
    @GetMapping("/info")
    public Result<User> getUserInfo(HttpServletRequest request) {
        // 从 Cookie 中获取 Token
        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        if (token == null || !jwtUtils.validateToken(token)) {
            return Result.error("未登录或登录已过期");
        }

        Long userId = jwtUtils.getUserIdFromToken(token);
        User user = userService.getById(userId);

        if (user == null) {
            return Result.error("用户不存在");
        }

        user.setPassword(null);
        return Result.success("获取成功", user);
    }

    /**
     * 发送验证码
     */
    @PostMapping("/sendCode")
    public Result<String> sendCode(@RequestParam String email) {
        return userService.sendCode(email);
    }

    /**
     * 重置密码
     */
    @PostMapping("/resetPassword")
    public Result<String> resetPassword(@RequestBody java.util.Map<String, String> params) {
        String email = params.get("email");
        String code = params.get("code");
        String newPassword = params.get("newPassword");
        return userService.resetPassword(email, code, newPassword);
    }

    /**
     * 修改密码（需验证旧密码）
     */
    @PostMapping("/changePassword")
    public Result<String> changePassword(@RequestBody java.util.Map<String, String> params,
            HttpServletRequest request) {
        String token = getTokenFromCookies(request);
        if (token == null || !jwtUtils.validateToken(token)) {
            return Result.error("未登录或登录已过期");
        }

        Long userId = jwtUtils.getUserIdFromToken(token);
        String oldPassword = params.get("oldPassword");
        String newPassword = params.get("newPassword");
        return userService.changePassword(userId, oldPassword, newPassword);
    }

    /**
     * 检查用户名是否已存在
     */
    @GetMapping("/checkUsername")
    public Result<Boolean> checkUsername(@RequestParam String username, HttpServletRequest request) {
        String token = getTokenFromCookies(request);
        Long currentUserId = null;

        if (token != null && jwtUtils.validateToken(token)) {
            currentUserId = jwtUtils.getUserIdFromToken(token);
        }

        boolean exists = userService.isUsernameExists(username, currentUserId);
        return Result.success(exists ? "用户名已存在" : "用户名可用", exists);
    }

    /**
     * 更新用户信息
     */
    @PostMapping("/update")
    public Result<User> updateUser(@RequestBody User updateInfo, HttpServletRequest request) {
        // 从 Cookie 中获取 Token
        String token = getTokenFromCookies(request);

        if (token == null || !jwtUtils.validateToken(token)) {
            return Result.error("未登录或登录已过期");
        }

        Long userId = jwtUtils.getUserIdFromToken(token);
        User user = userService.getById(userId);

        if (user == null) {
            return Result.error("用户不存在");
        }

        // 更新允许修改的字段
        if (updateInfo.getUsername() != null) {
            // 检查用户名是否与其他用户重复
            if (userService.isUsernameExists(updateInfo.getUsername(), userId)) {
                return Result.error("用户名已被其他用户使用");
            }
            user.setUsername(updateInfo.getUsername());
        }
        if (updateInfo.getGender() != null) {
            user.setGender(updateInfo.getGender());
        }
        if (updateInfo.getBio() != null) {
            user.setBio(updateInfo.getBio());
        }
        if (updateInfo.getAvatar() != null) {
            user.setAvatar(updateInfo.getAvatar());
        }

        userService.updateById(user);

        user.setPassword(null);
        return Result.success("更新成功", user);
    }

    /**
     * 更新邮箱
     */
    @PostMapping("/updateEmail")
    public Result<String> updateEmail(@RequestBody java.util.Map<String, String> params, HttpServletRequest request) {
        String token = getTokenFromCookies(request);

        if (token == null || !jwtUtils.validateToken(token)) {
            return Result.error("未登录或登录已过期");
        }

        Long userId = jwtUtils.getUserIdFromToken(token);
        String newEmail = params.get("email");
        String code = params.get("code");

        if (newEmail == null || code == null) {
            return Result.error("参数不完整");
        }

        // 验证验证码
        if (!userService.verifyCode(newEmail, code)) {
            return Result.error("验证码错误或已过期");
        }

        // 检查邮箱是否已被使用
        User existingUser = userService.getByEmail(newEmail);
        if (existingUser != null) {
            return Result.error("该邮箱已被使用");
        }

        User user = userService.getById(userId);
        user.setEmail(newEmail);
        userService.updateById(user);

        return Result.success("邮箱修改成功");
    }

    /**
     * 上传头像
     */
    @PostMapping("/uploadAvatar")
    public Result<String> uploadAvatar(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        String token = getTokenFromCookies(request);

        if (token == null || !jwtUtils.validateToken(token)) {
            return Result.error("未登录或登录已过期");
        }

        if (file.isEmpty()) {
            return Result.error("请选择文件");
        }

        // 验证文件类型
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return Result.error("只能上传图片文件");
        }

        // 验证文件大小（最大 2MB）
        if (file.getSize() > 2 * 1024 * 1024) {
            return Result.error("图片大小不能超过 2MB");
        }

        try {
            // 生成唯一文件名
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String newFilename = UUID.randomUUID().toString() + extension;

            // 创建上传目录
            File uploadDir = new File(uploadPath + "avatars/");
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 保存文件
            File destFile = new File(uploadDir, newFilename);
            file.transferTo(destFile);

            // 生成相对路径
            String avatarUrl = "/uploads/avatars/" + newFilename;

            // 更新用户头像
            Long userId = jwtUtils.getUserIdFromToken(token);
            User user = userService.getById(userId);
            user.setAvatar(avatarUrl);
            userService.updateById(user);

            return Result.success("上传成功", avatarUrl);
        } catch (IOException e) {
            return Result.error("上传失败：" + e.getMessage());
        }
    }

    /**
     * 获取管理员信息（用于首页展示）
     */
    @GetMapping("/admin")
    public Result<User> getAdminInfo() {
        User admin = userService.getAdmin();
        if (admin == null) {
            return Result.error("管理员不存在");
        }
        admin.setPassword(null);
        admin.setEmail(null); // 隐藏邮箱
        return Result.success("获取成功", admin);
    }

    @Autowired
    private com.mr.blog.mapper.RecordMapper recordMapper;

    @Autowired
    private com.mr.blog.mapper.RecordCategoryMapper categoryMapper;

    @Autowired
    private com.mr.blog.service.SiteVisitService siteVisitService;

    /**
     * 获取博主统计信息（文章数、分类数、网站访问量）
     */
    @GetMapping("/admin/stats")
    public Result<java.util.Map<String, Object>> getAdminStats() {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();

        // 统计已发布文章数
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<com.mr.blog.entity.Record> recordWrapper = new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        recordWrapper.eq(com.mr.blog.entity.Record::getStatus, 1);
        long articleCount = recordMapper.selectCount(recordWrapper);
        stats.put("articles", articleCount);

        // 统计分类数
        long categoryCount = categoryMapper.selectCount(null);
        stats.put("categories", categoryCount);

        // 获取网站总访问量
        long totalViews = siteVisitService.getTotalVisitCount();
        stats.put("views", totalViews);

        return Result.success(stats);
    }

    /**
     * 记录网站访问（前端页面加载时调用）
     */
    @PostMapping("/visit")
    public Result<Void> recordVisit() {
        siteVisitService.recordVisit();
        return Result.success();
    }

    // ==================== 管理端接口 ====================

    /**
     * 获取用户列表（管理端）
     */
    @GetMapping("/admin/list")
    public Result<PageVO<AdminUserVO>> getAdminUserList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Integer role,
            HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        int[] params = PageUtils.validateParams(page, size);
        PageVO<AdminUserVO> result = userService.getAdminUserList(params[0], params[1], keyword, role);
        return Result.success(result);
    }

    /**
     * 更新用户信息（管理端）
     */
    @PutMapping("/admin/update")
    public Result<String> updateUserByAdmin(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        Long id = body.get("id") != null ? Long.valueOf(body.get("id").toString()) : null;
        String username = body.get("username") != null ? body.get("username").toString() : null;
        Integer gender = body.get("gender") != null ? Integer.valueOf(body.get("gender").toString()) : null;
        String bio = body.get("bio") != null ? body.get("bio").toString() : null;

        if (id == null) {
            return Result.error("用户ID不能为空");
        }

        try {
            userService.updateUserByAdmin(id, username, gender, bio);
            return Result.success("更新成功");
        } catch (Exception e) {
            return Result.error("更新失败: " + e.getMessage());
        }
    }

    /**
     * 修改用户角色（管理端）
     */
    @PutMapping("/admin/role")
    public Result<String> updateUserRole(@RequestBody Map<String, Object> body, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        Long id = body.get("id") != null ? Long.valueOf(body.get("id").toString()) : null;
        Integer role = body.get("role") != null ? Integer.valueOf(body.get("role").toString()) : null;

        if (id == null || role == null) {
            return Result.error("参数不完整");
        }

        try {
            userService.updateUserRole(id, role);
            return Result.success("角色更新成功");
        } catch (Exception e) {
            return Result.error("更新失败: " + e.getMessage());
        }
    }

    /**
     * 删除用户（管理端）
     */
    @DeleteMapping("/admin/delete")
    public Result<String> deleteUserByAdmin(@RequestParam Long id, HttpServletRequest request) {
        if (!isAdmin(request)) {
            return Result.error(403, "无权限访问");
        }

        try {
            userService.deleteUserByAdmin(id);
            return Result.success("删除成功");
        } catch (Exception e) {
            return Result.error("删除失败: " + e.getMessage());
        }
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

    /**
     * 检查是否是管理员
     */
    private boolean isAdmin(HttpServletRequest request) {
        String token = getTokenFromCookies(request);
        if (token == null || !jwtUtils.validateToken(token)) {
            return false;
        }
        Long userId = jwtUtils.getUserIdFromToken(token);
        User user = userService.getById(userId);
        return user != null && user.getRole() == 1;
    }
}
