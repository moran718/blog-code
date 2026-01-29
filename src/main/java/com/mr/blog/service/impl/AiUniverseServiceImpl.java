package com.mr.blog.service.impl;

import com.mr.blog.service.AiUniverseService;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiUniverseServiceImpl implements AiUniverseService {

    @Autowired(required = false)
    private ChatModel chatModel;

    @Override
    public String simulate(String scenario) {
        if (chatModel == null) {
            return "Unable to observe universe: AI Engine offline.";
        }

        String prompt = String.format("""
                Role: Parallel Universe Life Simulator.
                User input (What IF): %s

                Task:
                1. Based on the user's 'What If' scenario, vividly describe their life in that timeline.
                2. Be creative, dramatic, or humorous.
                3. Structure:
                   - [Timeline Start]
                   - [Key Event]
                   - [Final Outcome]
                4. Language: Simplified Chinese (简体中文).
                5. Length: about 200 words.
                """, scenario);

        return chatModel.call(prompt);
    }
}
