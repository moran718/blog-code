package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.CommentRequest;
import com.mr.blog.dto.EssayRequest;
import com.mr.blog.dto.EssayVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.Essay;
import com.mr.blog.entity.EssayComment;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.EssayCommentMapper;
import com.mr.blog.mapper.EssayMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.EssayService;
import com.mr.blog.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class EssayServiceImpl implements EssayService {

    @Autowired
    private EssayMapper essayMapper;

    @Autowired
    private EssayCommentMapper commentMapper;

    @Autowired
    private UserMapper userMapper;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    @Override
    public PageVO<EssayVO> getEssayListWithPage(int page, int size) {
        // 1. 分页查询随笔
        Page<Essay> pageParam = PageUtils.createPage(page, size);
        LambdaQueryWrapper<Essay> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(Essay::getCreatedAt);
        Page<Essay> essayPage = essayMapper.selectPage(pageParam, wrapper);
        List<Essay> essays = essayPage.getRecords();

        if (essays.isEmpty()) {
            return PageUtils.toPageVO(essayPage, new ArrayList<>());
        }

        // 2. 获取所有相关用户
        Set<Long> userIds = new HashSet<>();
        essays.forEach(e -> userIds.add(e.getUserId()));

        // 获取所有评论
        List<Long> essayIds = essays.stream().map(Essay::getId).collect(Collectors.toList());
        LambdaQueryWrapper<EssayComment> commentWrapper = new LambdaQueryWrapper<>();
        commentWrapper.in(EssayComment::getEssayId, essayIds);
        commentWrapper.orderByAsc(EssayComment::getCreatedAt);
        List<EssayComment> allComments = commentMapper.selectList(commentWrapper);

        allComments.forEach(c -> {
            userIds.add(c.getUserId());
            if (c.getReplyToUserId() != null) {
                userIds.add(c.getReplyToUserId());
            }
        });

        // 查询所有用户
        Map<Long, User> userMap = new HashMap<>();
        if (!userIds.isEmpty()) {
            List<User> users = userMapper.selectBatchIds(userIds);
            users.forEach(u -> userMap.put(u.getId(), u));
        }

        // 3. 组装数据
        List<EssayVO> result = new ArrayList<>();
        for (Essay essay : essays) {
            EssayVO vo = new EssayVO();
            vo.setId(essay.getId());
            vo.setContent(essay.getContent());
            vo.setImages(parseImages(essay.getImages()));
            vo.setComments(essay.getCommentsCount() != null ? essay.getCommentsCount() : 0);
            vo.setDate(essay.getCreatedAt().format(DATE_FORMATTER));
            vo.setUser(buildUserVO(userMap.get(essay.getUserId())));

            // 获取该随笔的评论
            List<EssayComment> essayComments = allComments.stream()
                    .filter(c -> c.getEssayId().equals(essay.getId()))
                    .collect(Collectors.toList());

            // 分离一级评论和回复
            List<EssayComment> parentComments = essayComments.stream()
                    .filter(c -> c.getParentId() == null || c.getParentId() == 0)
                    .collect(Collectors.toList());

            List<EssayVO.CommentVO> commentVOList = new ArrayList<>();
            for (EssayComment parentComment : parentComments) {
                EssayVO.CommentVO commentVO = new EssayVO.CommentVO();
                commentVO.setId(parentComment.getId());
                commentVO.setUser(buildUserVO(userMap.get(parentComment.getUserId())));
                commentVO.setContent(parentComment.getContent());
                commentVO.setImages(parseImages(parentComment.getImages()));
                commentVO.setDate(parentComment.getCreatedAt().format(DATE_FORMATTER));

                // 获取回复
                List<EssayComment> replies = essayComments.stream()
                        .filter(c -> parentComment.getId().equals(c.getParentId()))
                        .collect(Collectors.toList());

                List<EssayVO.ReplyVO> replyVOList = new ArrayList<>();
                for (EssayComment reply : replies) {
                    EssayVO.ReplyVO replyVO = new EssayVO.ReplyVO();
                    replyVO.setId(reply.getId());
                    replyVO.setUser(buildUserVO(userMap.get(reply.getUserId())));
                    replyVO.setContent(reply.getContent());
                    replyVO.setImages(parseImages(reply.getImages()));
                    replyVO.setDate(reply.getCreatedAt().format(DATE_FORMATTER));

                    // 设置被回复用户名（三级回复）
                    if (reply.getReplyToUserId() != null) {
                        User replyToUser = userMap.get(reply.getReplyToUserId());
                        if (replyToUser != null) {
                            replyVO.setReplyTo(replyToUser.getUsername());
                        }
                    }
                    replyVOList.add(replyVO);
                }
                commentVO.setReplies(replyVOList);
                commentVOList.add(commentVO);
            }
            vo.setCommentList(commentVOList);
            result.add(vo);
        }

        return PageUtils.toPageVO(essayPage, result);
    }

    @Override
    @Transactional
    public void publishEssay(Long userId, EssayRequest request) {
        Essay essay = new Essay();
        essay.setUserId(userId);
        essay.setContent(request.getContent());
        essay.setImages(joinImages(request.getImages()));
        essay.setCommentsCount(0);
        essay.setCreatedAt(LocalDateTime.now());
        essay.setUpdatedAt(LocalDateTime.now());
        essayMapper.insert(essay);
    }

    @Override
    @Transactional
    public void deleteEssay(Long userId, Long essayId) {
        Essay essay = essayMapper.selectById(essayId);
        if (essay == null) {
            throw new RuntimeException("随笔不存在");
        }
        if (!essay.getUserId().equals(userId)) {
            throw new RuntimeException("无权删除他人随笔");
        }
        // 删除随笔及其评论
        essayMapper.deleteById(essayId);
        LambdaQueryWrapper<EssayComment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(EssayComment::getEssayId, essayId);
        commentMapper.delete(wrapper);
    }

    @Override
    @Transactional
    public EssayVO.CommentVO addComment(Long userId, CommentRequest request) {
        Essay essay = essayMapper.selectById(request.getEssayId());
        if (essay == null) {
            throw new RuntimeException("随笔不存在");
        }

        EssayComment comment = new EssayComment();
        comment.setEssayId(request.getEssayId());
        comment.setUserId(userId);
        comment.setParentId(request.getParentId() != null ? request.getParentId() : 0L);
        comment.setReplyToUserId(request.getReplyToUserId());
        comment.setContent(request.getContent());
        comment.setImages(joinImages(request.getImages()));
        comment.setCreatedAt(LocalDateTime.now());
        commentMapper.insert(comment);

        // 更新评论数
        essay.setCommentsCount((essay.getCommentsCount() != null ? essay.getCommentsCount() : 0) + 1);
        essayMapper.updateById(essay);

        // 构建并返回评论VO
        User user = userMapper.selectById(userId);
        EssayVO.CommentVO commentVO = new EssayVO.CommentVO();
        commentVO.setId(comment.getId());
        commentVO.setUser(buildUserVO(user));
        commentVO.setContent(comment.getContent());
        commentVO.setImages(parseImages(comment.getImages()));
        commentVO.setDate(comment.getCreatedAt().format(DATE_FORMATTER));
        commentVO.setReplies(new ArrayList<>());

        return commentVO;
    }

    @Override
    @Transactional
    public void deleteComment(Long userId, Long commentId) {
        EssayComment comment = commentMapper.selectById(commentId);
        if (comment == null) {
            throw new RuntimeException("评论不存在");
        }
        if (!comment.getUserId().equals(userId)) {
            throw new RuntimeException("无权删除他人评论");
        }

        // 删除评论及其回复
        int deleteCount = 1;
        if (comment.getParentId() == null || comment.getParentId() == 0) {
            // 一级评论，删除其所有回复
            LambdaQueryWrapper<EssayComment> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(EssayComment::getParentId, commentId);
            deleteCount += commentMapper.delete(wrapper);
        }
        commentMapper.deleteById(commentId);

        // 更新评论数
        Essay essay = essayMapper.selectById(comment.getEssayId());
        if (essay != null) {
            essay.setCommentsCount(
                    Math.max(0, (essay.getCommentsCount() != null ? essay.getCommentsCount() : 0) - deleteCount));
            essayMapper.updateById(essay);
        }
    }

    private EssayVO.UserVO buildUserVO(User user) {
        if (user == null) {
            EssayVO.UserVO vo = new EssayVO.UserVO();
            vo.setId(0L);
            vo.setName("未知用户");
            vo.setAvatar("https://api.dicebear.com/7.x/avataaars/svg?seed=unknown");
            vo.setLevel(1);
            vo.setTitle("新人");
            return vo;
        }
        EssayVO.UserVO vo = new EssayVO.UserVO();
        vo.setId(user.getId());
        vo.setName(user.getUsername());
        vo.setAvatar(user.getAvatar() != null ? user.getAvatar()
                : "https://api.dicebear.com/7.x/avataaars/svg?seed=" + user.getId());
        vo.setLevel(user.getLevel() != null ? user.getLevel() : 1);
        vo.setTitle(user.getTitle() != null ? user.getTitle() : "新人");
        return vo;
    }

    private List<String> parseImages(String images) {
        if (images == null || images.isEmpty()) {
            return new ArrayList<>();
        }
        return Arrays.asList(images.split(","));
    }

    private String joinImages(List<String> images) {
        if (images == null || images.isEmpty()) {
            return null;
        }
        return String.join(",", images);
    }

    @Override
    public PageVO<EssayVO.CommentVO> getEssayComments(Long essayId, int page, int pageSize) {
        // 1. 分页查询一级评论
        LambdaQueryWrapper<EssayComment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(EssayComment::getEssayId, essayId)
                .and(w -> w.isNull(EssayComment::getParentId).or().eq(EssayComment::getParentId, 0L))
                .orderByAsc(EssayComment::getCreatedAt);

        Page<EssayComment> pageParam = PageUtils.createPage(page, pageSize);
        Page<EssayComment> commentPage = commentMapper.selectPage(pageParam, wrapper);
        List<EssayComment> parentComments = commentPage.getRecords();

        if (parentComments.isEmpty()) {
            return PageUtils.toPageVO(commentPage, new ArrayList<>());
        }

        // 2. 获取所有回复
        List<Long> parentIds = parentComments.stream().map(EssayComment::getId).collect(Collectors.toList());
        LambdaQueryWrapper<EssayComment> replyWrapper = new LambdaQueryWrapper<>();
        replyWrapper.in(EssayComment::getParentId, parentIds)
                .orderByAsc(EssayComment::getCreatedAt);
        List<EssayComment> allReplies = commentMapper.selectList(replyWrapper);

        // 3. 收集所有用户ID
        Set<Long> userIds = new HashSet<>();
        parentComments.forEach(c -> userIds.add(c.getUserId()));
        allReplies.forEach(c -> {
            userIds.add(c.getUserId());
            if (c.getReplyToUserId() != null) {
                userIds.add(c.getReplyToUserId());
            }
        });

        // 4. 查询所有用户
        Map<Long, User> userMap = new HashMap<>();
        if (!userIds.isEmpty()) {
            List<User> users = userMapper.selectBatchIds(userIds);
            users.forEach(u -> userMap.put(u.getId(), u));
        }

        // 5. 组装数据
        List<EssayVO.CommentVO> result = new ArrayList<>();
        for (EssayComment parentComment : parentComments) {
            EssayVO.CommentVO commentVO = new EssayVO.CommentVO();
            commentVO.setId(parentComment.getId());
            commentVO.setUser(buildUserVO(userMap.get(parentComment.getUserId())));
            commentVO.setContent(parentComment.getContent());
            commentVO.setImages(parseImages(parentComment.getImages()));
            commentVO.setDate(parentComment.getCreatedAt().format(DATE_FORMATTER));

            // 获取回复
            List<EssayComment> replies = allReplies.stream()
                    .filter(c -> parentComment.getId().equals(c.getParentId()))
                    .collect(Collectors.toList());

            List<EssayVO.ReplyVO> replyVOList = new ArrayList<>();
            for (EssayComment reply : replies) {
                EssayVO.ReplyVO replyVO = new EssayVO.ReplyVO();
                replyVO.setId(reply.getId());
                replyVO.setUser(buildUserVO(userMap.get(reply.getUserId())));
                replyVO.setContent(reply.getContent());
                replyVO.setImages(parseImages(reply.getImages()));
                replyVO.setDate(reply.getCreatedAt().format(DATE_FORMATTER));

                if (reply.getReplyToUserId() != null) {
                    User replyToUser = userMap.get(reply.getReplyToUserId());
                    if (replyToUser != null) {
                        replyVO.setReplyTo(replyToUser.getUsername());
                    }
                }
                replyVOList.add(replyVO);
            }
            commentVO.setReplies(replyVOList);
            result.add(commentVO);
        }

        return PageUtils.toPageVO(commentPage, result);
    }
}
