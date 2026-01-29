package com.mr.blog.service;

/**
 * AI 自动回复服务接口
 */
public interface AiReplyService {

    /**
     * 检查是否开启 AI 回复
     */
    boolean isAiReplyEnabled();

    /**
     * 设置 AI 回复开关
     */
    void setAiReplyEnabled(boolean enabled);

    /**
     * 异步生成并发布 AI 回复
     *
     * @param essayId        随笔ID
     * @param commentId      评论ID（AI回复的父评论）
     * @param commentContent 用户评论内容
     */
    void generateAndPostReply(Long essayId, Long commentId, String commentContent);
}
