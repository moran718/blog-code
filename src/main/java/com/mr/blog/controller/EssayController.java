package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.dto.CommentRequest;
import com.mr.blog.dto.EssayRequest;
import com.mr.blog.dto.EssayVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.service.EssayService;
import com.mr.blog.utils.JwtUtils;
import com.mr.blog.utils.PageUtils;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
@RequestMapping("/api/essay")
@CrossOrigin
public class EssayController {

    @Autowired
    private EssayService essayService;

    @Autowired
    private JwtUtils jwtUtils;

    @org.springframework.beans.factory.annotation.Value("${file.upload-path}")
    private String uploadPath;

    /**
     * 获取随笔列表（分页）
     */
    @GetMapping("/list")
    public Result<PageVO<EssayVO>> getEssayList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "5") Integer size) {
        int[] params = PageUtils.validateParams(page, size);
        PageVO<EssayVO> result = essayService.getEssayListWithPage(params[0], params[1]);
        return Result.success(result);
    }

    /**
     * 发布随笔
     */
    @PostMapping("/publish")
    public Result<Void> publishEssay(@RequestBody EssayRequest request, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        if (request.getContent() == null || request.getContent().trim().isEmpty()) {
            return Result.error("随笔内容不能为空");
        }
        essayService.publishEssay(userId, request);
        return Result.success();
    }

    /**
     * 删除随笔
     */
    @DeleteMapping("/{id}")
    public Result<Void> deleteEssay(@PathVariable Long id, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        try {
            essayService.deleteEssay(userId, id);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 发表评论
     */
    @PostMapping("/comment")
    public Result<EssayVO.CommentVO> addComment(@RequestBody CommentRequest request, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        if (request.getEssayId() == null) {
            return Result.error("随笔ID不能为空");
        }
        if ((request.getContent() == null || request.getContent().trim().isEmpty())
                && (request.getImages() == null || request.getImages().isEmpty())) {
            return Result.error("评论内容或图片不能为空");
        }
        try {
            EssayVO.CommentVO commentVO = essayService.addComment(userId, request);
            return Result.success(commentVO);
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 删除评论
     */
    @DeleteMapping("/comment/{id}")
    public Result<Void> deleteComment(@PathVariable Long id, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        try {
            essayService.deleteComment(userId, id);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 获取随笔评论列表（分页）
     */
    @GetMapping("/{essayId}/comments")
    public Result<PageVO<EssayVO.CommentVO>> getEssayComments(
            @PathVariable Long essayId,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "5") Integer pageSize) {
        int[] params = PageUtils.validateParams(page, pageSize);
        PageVO<EssayVO.CommentVO> result = essayService.getEssayComments(essayId, params[0], params[1]);
        return Result.success(result);
    }

    /**
     * 上传随笔图片
     */
    @PostMapping("/uploadImage")
    public Result<String> uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

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
            String essayImagePath = uploadPath + "essays/";
            File dir = new File(essayImagePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File destFile = new File(essayImagePath + newFilename);
            file.transferTo(destFile);

            // 返回相对路径
            String imageUrl = "/uploads/essays/" + newFilename;
            return Result.success(imageUrl);
        } catch (IOException e) {
            return Result.error("上传失败: " + e.getMessage());
        }
    }

    /**
     * 上传随笔视频
     */
    @PostMapping("/uploadVideo")
    public Result<String> uploadVideo(@RequestParam("file") MultipartFile file, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }

        if (file.isEmpty()) {
            return Result.error("文件不能为空");
        }

        // 验证文件类型
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("video/")) {
            return Result.error("只能上传视频文件");
        }

        // 验证文件大小（最大100MB）
        if (file.getSize() > 100 * 1024 * 1024) {
            return Result.error("视频大小不能超过100MB");
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
            String essayVideoPath = uploadPath + "essays/videos/";
            File dir = new File(essayVideoPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            File destFile = new File(essayVideoPath + newFilename);
            file.transferTo(destFile);

            // 返回相对路径
            String videoUrl = "/uploads/essays/videos/" + newFilename;
            return Result.success(videoUrl);
        } catch (IOException e) {
            return Result.error("上传失败: " + e.getMessage());
        }
    }

    // ==================== 管理端接口 ====================

    /**
     * 管理端：获取随笔列表（分页）
     */
    @GetMapping("/admin/list")
    public Result<PageVO<EssayVO>> getAdminEssayList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size,
            @RequestParam(required = false) String keyword,
            HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        int[] params = PageUtils.validateParams(page, size);
        PageVO<EssayVO> result = essayService.getAdminEssayList(params[0], params[1], keyword);
        return Result.success(result);
    }

    /**
     * 管理端：删除随笔（管理员可删除任何随笔）
     */
    @DeleteMapping("/admin/{id}")
    public Result<Void> adminDeleteEssay(@PathVariable Long id, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        try {
            essayService.adminDeleteEssay(id);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    /**
     * 管理端：删除评论（管理员可删除任何评论）
     */
    @DeleteMapping("/admin/comment/{id}")
    public Result<Void> adminDeleteComment(@PathVariable Long id, HttpServletRequest httpRequest) {
        Long userId = getCurrentUserId(httpRequest);
        if (userId == null) {
            return Result.error(401, "请先登录");
        }
        try {
            essayService.adminDeleteComment(id);
            return Result.success();
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
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
