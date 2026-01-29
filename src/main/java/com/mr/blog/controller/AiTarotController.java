package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.service.AiTarotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
public class AiTarotController {

    @Autowired
    private AiTarotService aiTarotService;

    @PostMapping("/tarot")
    public Result<Map<String, Object>> draw(@RequestBody Map<String, String> params) {
        String question = params.get("question");
        try {
            return Result.success(aiTarotService.drawCard(question));
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
