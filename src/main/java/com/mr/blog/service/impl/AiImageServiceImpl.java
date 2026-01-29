package com.mr.blog.service.impl;

import com.mr.blog.service.AiImageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.image.ImageModel;
import org.springframework.ai.image.ImagePrompt;
import org.springframework.ai.image.ImageOptionsBuilder;
import org.springframework.ai.image.ImageResponse;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiImageServiceImpl implements AiImageService {

    private static final Logger logger = LoggerFactory.getLogger(AiImageServiceImpl.class);

    @Autowired(required = false)
    private ImageModel imageModel;

    @Autowired(required = false)
    private ChatModel chatModel;

    @Override
    public String generateOptimizedCover(String title, String content) {
        if (chatModel == null) {
            return generateCover(title);
        }

        String subContent = content != null ? content.substring(0, Math.min(content.length(), 500)) : "";
        // Remove line breaks to avoid format issues
        subContent = subContent.replace("\n", " ");

        String promptTemplate = "You are an art director. Create a high-quality, English text-to-image prompt for a blog cover based on Title: '%s' and Content: '%s'. Style: Modern, Artistic, Abstract or Illustration. No text in image. Output ONLY the prompt.";
        String userMsg = String.format(promptTemplate, title, subContent);

        String optimizedPrompt = chatModel.call(userMsg);
        logger.info("Optimized Prompt: {}", optimizedPrompt);

        return generateCover(optimizedPrompt);
    }

    @Override
    public String generateCover(String prompt) {
        if (imageModel == null) {
            logger.error("AI Image Model is not configured or bean is missing.");
            throw new RuntimeException("AI作画服务未配置，请检查服务端配置");
        }

        logger.info("开始生成图片，prompt: {}", prompt);
        try {
            // Explicitly set model to wanx-v1 and size
            ImageResponse response = imageModel.call(new ImagePrompt(prompt,
                    ImageOptionsBuilder.builder()
                            .withModel("wanx-v1")
                            .withWidth(1024)
                            .withHeight(1024)
                            .build()));

            if (response != null && response.getResult() != null && response.getResult().getOutput() != null) {
                String url = response.getResult().getOutput().getUrl();
                logger.info("图片生成成功: {}", url);
                return url;
            }
        } catch (Exception e) {
            logger.error("调用AI作画失败", e);
            throw new RuntimeException("生成图片失败: " + e.getMessage());
        }

        throw new RuntimeException("生成图片失败，无返回结果");
    }
}
