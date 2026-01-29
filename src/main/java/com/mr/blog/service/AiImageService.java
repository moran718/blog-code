package com.mr.blog.service;

public interface AiImageService {
    /**
     * 根据提示词生成封面图，并返回图片 URL
     * 
     * @param prompt 提示词
     * @return 图片 URL
     */
    String generateCover(String prompt);

    /**
     * 根据文章标题和内容生成优化后的封面
     */
    String generateOptimizedCover(String title, String content);
}
