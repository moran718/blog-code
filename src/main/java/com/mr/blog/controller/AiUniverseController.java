package com.mr.blog.controller;

import com.mr.blog.common.Result;
import com.mr.blog.service.AiUniverseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
public class AiUniverseController {

    @Autowired
    private AiUniverseService aiUniverseService;

    @PostMapping("/universe")
    public Result<String> simulate(@RequestBody Map<String, String> params) {
        String scenario = params.get("scenario");
        if (scenario == null || scenario.trim().isEmpty()) {
            return Result.error("请输入观测条件");
        }
        try {
            return Result.success(aiUniverseService.simulate(scenario));
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }
}
