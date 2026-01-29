package com.mr.blog.service.impl;

import com.alibaba.cloud.ai.dashscope.chat.DashScopeChatModel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.entity.Essay;
import com.mr.blog.entity.EssayComment;
import com.mr.blog.entity.SystemConfig;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.EssayCommentMapper;
import com.mr.blog.mapper.EssayMapper;
import com.mr.blog.mapper.SystemConfigMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.AiReplyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

/**
 * AI 自动回复服务实现
 */
@Service
public class AiReplyServiceImpl implements AiReplyService {

    private static final Logger logger = LoggerFactory.getLogger(AiReplyServiceImpl.class);

    private static final String AI_REPLY_ENABLED_KEY = "ai_reply_enabled";
    private static final String AI_USER_NAME = "AI助手";

    @Autowired
    private DashScopeChatModel chatModel;

    @Autowired
    private SystemConfigMapper systemConfigMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private EssayMapper essayMapper;

    @Autowired
    private EssayCommentMapper commentMapper;

    @Override
    public boolean isAiReplyEnabled() {
        LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SystemConfig::getConfigKey, AI_REPLY_ENABLED_KEY);
        SystemConfig config = systemConfigMapper.selectOne(wrapper);
        return config != null && "true".equalsIgnoreCase(config.getConfigValue());
    }

    @Override
    @Transactional
    public void setAiReplyEnabled(boolean enabled) {
        LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SystemConfig::getConfigKey, AI_REPLY_ENABLED_KEY);
        SystemConfig config = systemConfigMapper.selectOne(wrapper);

        if (config == null) {
            config = new SystemConfig();
            config.setConfigKey(AI_REPLY_ENABLED_KEY);
            config.setDescription("AI自动回复开关");
        }
        config.setConfigValue(enabled ? "true" : "false");
        config.setUpdatedAt(LocalDateTime.now());

        if (config.getId() == null) {
            systemConfigMapper.insert(config);
        } else {
            systemConfigMapper.updateById(config);
        }
    }

    @Override
    @Async("aiReplyExecutor")
    @Transactional
    public void generateAndPostReply(Long essayId, Long commentId, String commentContent) {
        try {
            logger.info("开始生成 AI 回复，评论ID: {}, 内容: {}", commentId, commentContent);

            // 获取或创建 AI 用户
            Long aiUserId = getOrCreateAiUser();

            // 生成 AI 回复
            String aiReply = generateAiReply(commentContent);
            if (aiReply == null || aiReply.trim().isEmpty()) {
                logger.warn("AI 回复生成失败或为空");
                return;
            }

            // 保存回复评论
            EssayComment replyComment = new EssayComment();
            replyComment.setEssayId(essayId);
            replyComment.setUserId(aiUserId);
            replyComment.setParentId(commentId);
            replyComment.setContent(aiReply);
            replyComment.setCreatedAt(LocalDateTime.now());
            commentMapper.insert(replyComment);

            // 更新评论数
            Essay essay = essayMapper.selectById(essayId);
            if (essay != null) {
                essay.setCommentsCount((essay.getCommentsCount() != null ? essay.getCommentsCount() : 0) + 1);
                essayMapper.updateById(essay);
            }

            logger.info("AI 回复发布成功，回复内容: {}", aiReply);
        } catch (Exception e) {
            logger.error("AI 回复生成失败", e);
        }
    }

    /**
     * 调用通义千问生成回复
     */
    private String generateAiReply(String userComment) {
        String prompt = String.format("""
                你是一个友好的博客 AI 助手。用户发表了一条评论，请生成一个简短、友好的回复。

                要求：
                1. 回复简洁，不超过 50 字
                2. 语气亲切友好
                3. 可以适当使用 1-2 个表情符号
                4. 不要重复用户的内容
                5. 直接输出回复内容，不要有任何前缀

                用户评论：%s
                """, userComment);

        return chatModel.call(prompt);
    }

    /**
     * 获取或创建 AI 助手用户
     */
    private Long getOrCreateAiUser() {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getUsername, AI_USER_NAME);
        User aiUser = userMapper.selectOne(wrapper);

        if (aiUser == null) {
            aiUser = new User();
            aiUser.setUsername(AI_USER_NAME);
            aiUser.setEmail("ai@blog.local");
            aiUser.setPassword(""); // AI 用户不需要密码
            aiUser.setAvatar("https://api.dicebear.com/7.x/bottts/svg?seed=ai-assistant&backgroundColor=b6e3f4");
            aiUser.setLevelId(1);
            aiUser.setCreateTime(LocalDateTime.now());
            userMapper.insert(aiUser);
        }

        return aiUser.getId();
    }
}
