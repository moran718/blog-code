package com.mr.blog.controller;

import com.mr.blog.entity.Record;
import com.mr.blog.mapper.RecordMapper;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/api/ai")
public class AiStreamController {

    private static final Logger logger = LoggerFactory.getLogger(AiStreamController.class);
    private final ChatClient chatClient;
    private final RecordMapper recordMapper;

    public AiStreamController(ChatClient.Builder builder, RecordMapper mapper) {
        this.chatClient = builder.build();
        this.recordMapper = mapper;
    }

    @GetMapping(value = "/summary/{id}", produces = "text/plain;charset=UTF-8")
    public Flux<String> summary(@PathVariable Long id, HttpServletResponse res) {
        res.setCharacterEncoding("UTF-8");
        res.setHeader("Cache-Control", "no-cache");
        
        Record r = recordMapper.selectById(id);
        if (r == null) {
            return Flux.just("Not found");
        }
        
        String c = r.getContent();
        if (c != null && c.length() > 3000) {
            c = c.substring(0, 3000);
        }
        
        String p = "Summarize in Chinese (300-400 chars): " + r.getTitle() + " - " + c;
        
        return chatClient.prompt(p).stream().content()
            .onErrorResume(e -> Flux.just("Error: " + e.getMessage()));
    }
}
