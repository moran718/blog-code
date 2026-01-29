package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.service.AiImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
public class AiImageController {

    @Autowired
    private AiImageService aiImageService;

    @PostMapping("/generate-image")
    public Result<String> generateImage(@RequestBody Map<String, String> params) {
        String title = params.get("prompt");
        String content = params.get("content");

        if (title == null || title.trim().isEmpty()) {
            return Result.error("标题不能为空");
        }

        try {
            String url = aiImageService.generateOptimizedCover(title, content);
            return Result.success(url);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
