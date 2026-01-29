package com.mr.blog.service.impl;

import com.mr.blog.service.AiTarotService;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class AiTarotServiceImpl implements AiTarotService {

    private static final String[] MAJOR_ARCANA = {
            "The Fool (愚者)", "The Magician (魔术师)", "The High Priestess (女祭司)",
            "The Empress (皇后)", "The Emperor (皇帝)", "The Hierophant (教皇)",
            "The Lovers (恋人)", "The Chariot (战车)", "Strength (力量)",
            "The Hermit (隐士)", "Wheel of Fortune (命运之轮)", "Justice (正义)",
            "The Hanged Man (倒吊人)", "Death (死神)", "Temperance (节制)",
            "The Devil (恶魔)", "The Tower (高塔)", "The Star (星星)",
            "The Moon (月亮)", "The Sun (太阳)", "Judgement (审判)", "The World (世界)"
    };

    @Autowired(required = false)
    private ChatModel chatModel;

    @Override
    public Map<String, Object> drawCard(String question) {
        Random rand = new Random();
        String card = MAJOR_ARCANA[rand.nextInt(MAJOR_ARCANA.length)];
        boolean isUpright = rand.nextBoolean();
        String position = isUpright ? "正位 (Upright)" : "逆位 (Reversed)";

        String finalQuestion = (question == null || question.trim().isEmpty()) ? "Current Fortunes" : question;

        String interpretation;
        if (chatModel != null) {
            String prompt = String.format("""
                    You are a Cyberpunk Mystical AI.
                    Task: Interpret the Tarot card: [%s], Position: [%s].
                    User's Query: [%s]

                    Style Guidelines:
                    - Use Cyberpunk/Tech metaphors (e.g. 'System glitch', 'Upgrade', 'Data flow', 'Firewall').
                    - Tone: Mysterious, philosophical, but helpful.
                    - Language: Simplified Chinese (简体中文).
                    - Length: Concise, around 100-150 words.

                    Output only the interpretation text.
                    """, card, position, finalQuestion);
            interpretation = chatModel.call(prompt);
        } else {
            interpretation = "System Offline... The Spirits are unreachable. (Check Backend Configuration)";
        }

        Map<String, Object> result = new HashMap<>();
        result.put("card", card);
        result.put("position", position);
        result.put("interpretation", interpretation);
        return result;
    }
}
