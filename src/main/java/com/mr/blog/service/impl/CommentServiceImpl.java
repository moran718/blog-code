package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.dto.AdminCommentVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.Essay;
import com.mr.blog.entity.EssayComment;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.EssayCommentMapper;
import com.mr.blog.mapper.EssayMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 随笔评论管理服务实现
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private EssayCommentMapper essayCommentMapper;

    @Autowired
    private EssayMapper essayMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public PageVO<AdminCommentVO> getAdminCommentList(int page, int size, String keyword) {
        // 查询随笔评论
        List<EssayComment> essayComments = queryEssayComments(keyword);

        // 收集所有用户ID
        Set<Long> userIds = new HashSet<>();
        for (EssayComment comment : essayComments) {
            userIds.add(comment.getUserId());
            // 收集被回复用户ID
            if (comment.getReplyToUserId() != null && comment.getReplyToUserId() > 0) {
                userIds.add(comment.getReplyToUserId());
            }
        }

        // 获取随笔信息
        Set<Long> essayIds = essayComments.stream()
                .map(EssayComment::getEssayId)
                .collect(Collectors.toSet());
        Map<Long, Essay> essayMap = new HashMap<>();
        if (!essayIds.isEmpty()) {
            List<Essay> essays = essayMapper.selectBatchIds(essayIds);
            essays.forEach(e -> essayMap.put(e.getId(), e));
        }

        // 查询用户信息
        Map<Long, User> userMap = new HashMap<>();
        if (!userIds.isEmpty()) {
            List<User> users = userMapper.selectBatchIds(userIds);
            users.forEach(u -> userMap.put(u.getId(), u));
        }

        // 转换为VO列表
        List<AdminCommentVO> allComments = new ArrayList<>();
        for (EssayComment comment : essayComments) {
            AdminCommentVO vo = new AdminCommentVO();
            vo.setId(comment.getId());
            vo.setUserId(comment.getUserId());
            vo.setContent(comment.getContent());
            vo.setImages(comment.getImages());
            vo.setImageList(parseImages(comment.getImages()));
            vo.setTargetId(comment.getEssayId());
            vo.setIsReply(comment.getParentId() != null && comment.getParentId() > 0);
            vo.setParentId(comment.getParentId());
            vo.setReplyToUserId(comment.getReplyToUserId());
            vo.setCreatedAt(comment.getCreatedAt());

            // 设置随笔内容预览
            Essay essay = essayMap.get(comment.getEssayId());
            if (essay != null) {
                String content = essay.getContent();
                vo.setTargetTitle(content != null && content.length() > 30
                        ? content.substring(0, 30) + "..."
                        : content);
            }

            // 填充评论用户信息
            User user = userMap.get(comment.getUserId());
            if (user != null) {
                vo.setUsername(user.getUsername());
                vo.setAvatar(user.getAvatar());
            } else {
                vo.setUsername("未知用户");
                vo.setAvatar(null);
            }

            // 填充被回复用户信息
            if (comment.getReplyToUserId() != null && comment.getReplyToUserId() > 0) {
                User replyToUser = userMap.get(comment.getReplyToUserId());
                if (replyToUser != null) {
                    vo.setReplyToUsername(replyToUser.getUsername());
                } else {
                    vo.setReplyToUsername("未知用户");
                }
            }

            allComments.add(vo);
        }

        // 手动分页
        int total = allComments.size();
        int start = (page - 1) * size;
        int end = Math.min(start + size, total);

        List<AdminCommentVO> pageList = start < total
                ? allComments.subList(start, end)
                : new ArrayList<>();

        return PageVO.of(pageList, total, page, size);
    }

    /**
     * 解析图片字符串为数组
     */
    private String[] parseImages(String images) {
        if (!StringUtils.hasText(images)) {
            return null;
        }
        return images.split(",");
    }

    /**
     * 查询随笔评论（支持关键词搜索）
     */
    private List<EssayComment> queryEssayComments(String keyword) {
        LambdaQueryWrapper<EssayComment> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.like(EssayComment::getContent, keyword);
        }
        wrapper.orderByDesc(EssayComment::getCreatedAt);
        return essayCommentMapper.selectList(wrapper);
    }

    @Override
    @Transactional
    public void deleteCommentByAdmin(Long id) {
        EssayComment comment = essayCommentMapper.selectById(id);
        if (comment == null) {
            throw new RuntimeException("评论不存在");
        }

        int deleteCount = 1;
        // 如果是一级评论，删除其所有回复
        if (comment.getParentId() == null || comment.getParentId() == 0) {
            LambdaQueryWrapper<EssayComment> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(EssayComment::getParentId, id);
            deleteCount += essayCommentMapper.delete(wrapper);
        }
        essayCommentMapper.deleteById(id);

        // 更新随笔评论数
        Essay essay = essayMapper.selectById(comment.getEssayId());
        if (essay != null) {
            essay.setCommentsCount(
                    Math.max(0, (essay.getCommentsCount() != null ? essay.getCommentsCount() : 0) - deleteCount));
            essayMapper.updateById(essay);
        }
    }
}
