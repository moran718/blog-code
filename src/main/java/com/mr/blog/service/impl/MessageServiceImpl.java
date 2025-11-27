package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.DanmakuVO;
import com.mr.blog.dto.MessageRequest;
import com.mr.blog.dto.MessageReplyRequest;
import com.mr.blog.dto.MessageVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.Message;
import com.mr.blog.entity.MessageLike;
import com.mr.blog.entity.MessageReply;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.MessageLikeMapper;
import com.mr.blog.mapper.MessageMapper;
import com.mr.blog.mapper.MessageReplyMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.MessageService;
import com.mr.blog.utils.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MessageServiceImpl implements MessageService {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private MessageReplyMapper messageReplyMapper;

    @Autowired
    private MessageLikeMapper messageLikeMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<DanmakuVO> getDanmakuList(Long userId) {
        // 查询所有弹幕（type=0）
        LambdaQueryWrapper<Message> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Message::getType, 0)
                .orderByDesc(Message::getCreatedAt);
        List<Message> messages = messageMapper.selectList(wrapper);

        if (messages.isEmpty()) {
            return new ArrayList<>();
        }

        // 获取用户信息
        Set<Long> userIds = messages.stream().map(Message::getUserId).collect(Collectors.toSet());
        List<User> users = userMapper.selectBatchIds(userIds);
        Map<Long, User> userMap = users.stream().collect(Collectors.toMap(User::getId, u -> u));

        // 获取当前用户点赞记录
        Set<Long> likedMessageIds = new HashSet<>();
        if (userId != null) {
            LambdaQueryWrapper<MessageLike> likeWrapper = new LambdaQueryWrapper<>();
            likeWrapper.eq(MessageLike::getUserId, userId);
            List<MessageLike> likes = messageLikeMapper.selectList(likeWrapper);
            likedMessageIds = likes.stream().map(MessageLike::getMessageId).collect(Collectors.toSet());
        }

        // 组装返回数据
        List<DanmakuVO> result = new ArrayList<>();
        for (Message msg : messages) {
            DanmakuVO vo = new DanmakuVO();
            vo.setId(msg.getId());
            vo.setContent(msg.getContent());
            vo.setLikes(msg.getLikes() != null ? msg.getLikes() : 0);
            vo.setLiked(likedMessageIds.contains(msg.getId()));

            User user = userMap.get(msg.getUserId());
            if (user != null) {
                vo.setAvatar(user.getAvatar());
            } else {
                vo.setAvatar("https://api.dicebear.com/7.x/avataaars/svg?seed=" + msg.getId());
            }
            result.add(vo);
        }
        return result;
    }

    @Override
    @Transactional
    public void sendDanmaku(Long userId, String content) {
        Message message = new Message();
        message.setUserId(userId);
        message.setType(0); // 弹幕
        message.setContent(content);
        message.setLikes(0);
        message.setCreatedAt(LocalDateTime.now());
        messageMapper.insert(message);
    }

    @Override
    @Transactional
    public boolean toggleLike(Long userId, Long messageId) {
        // 检查是否已点赞
        LambdaQueryWrapper<MessageLike> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MessageLike::getUserId, userId)
                .eq(MessageLike::getMessageId, messageId);
        MessageLike existing = messageLikeMapper.selectOne(wrapper);

        Message message = messageMapper.selectById(messageId);
        if (message == null) {
            return false;
        }

        if (existing != null) {
            // 取消点赞
            messageLikeMapper.deleteById(existing.getId());
            message.setLikes(Math.max(0, message.getLikes() - 1));
            messageMapper.updateById(message);
            return false;
        } else {
            // 添加点赞
            MessageLike like = new MessageLike();
            like.setUserId(userId);
            like.setMessageId(messageId);
            like.setCreatedAt(LocalDateTime.now());
            messageLikeMapper.insert(like);
            message.setLikes(message.getLikes() + 1);
            messageMapper.updateById(message);
            return true;
        }
    }

    @Override
    public List<MessageVO> getMessageList() {
        // 查询所有留言（type=1）
        LambdaQueryWrapper<Message> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Message::getType, 1)
                .orderByDesc(Message::getCreatedAt);
        List<Message> messages = messageMapper.selectList(wrapper);

        if (messages.isEmpty()) {
            return new ArrayList<>();
        }

        // 获取留言ID列表
        List<Long> messageIds = messages.stream().map(Message::getId).collect(Collectors.toList());

        // 获取所有回复
        LambdaQueryWrapper<MessageReply> replyWrapper = new LambdaQueryWrapper<>();
        replyWrapper.in(MessageReply::getMessageId, messageIds)
                .orderByAsc(MessageReply::getCreatedAt);
        List<MessageReply> allReplies = messageReplyMapper.selectList(replyWrapper);

        // 获取所有相关用户
        Set<Long> userIds = new HashSet<>();
        messages.forEach(m -> userIds.add(m.getUserId()));
        allReplies.forEach(r -> {
            userIds.add(r.getUserId());
            if (r.getReplyToUserId() != null) {
                userIds.add(r.getReplyToUserId());
            }
        });
        List<User> users = userMapper.selectBatchIds(userIds);
        Map<Long, User> userMap = users.stream().collect(Collectors.toMap(User::getId, u -> u));

        // 组装返回数据
        List<MessageVO> result = new ArrayList<>();
        for (Message msg : messages) {
            MessageVO vo = new MessageVO();
            vo.setId(msg.getId());
            vo.setContent(msg.getContent());
            vo.setImages(parseImages(msg.getImages()));
            vo.setDate(msg.getCreatedAt().format(DATE_FORMATTER));
            vo.setUser(buildUserVO(userMap.get(msg.getUserId())));

            // 获取该留言的回复
            List<MessageReply> replies = allReplies.stream()
                    .filter(r -> r.getMessageId().equals(msg.getId()))
                    .collect(Collectors.toList());

            List<MessageVO.ReplyVO> replyVOs = new ArrayList<>();
            for (MessageReply reply : replies) {
                MessageVO.ReplyVO replyVO = new MessageVO.ReplyVO();
                replyVO.setId(reply.getId());
                replyVO.setContent(reply.getContent());
                replyVO.setDate(reply.getCreatedAt().format(DATE_FORMATTER));
                replyVO.setUser(buildUserVO(userMap.get(reply.getUserId())));

                if (reply.getReplyToUserId() != null) {
                    User replyToUser = userMap.get(reply.getReplyToUserId());
                    if (replyToUser != null) {
                        replyVO.setReplyTo(replyToUser.getUsername());
                    }
                }
                replyVOs.add(replyVO);
            }
            vo.setReplies(replyVOs);
            result.add(vo);
        }
        return result;
    }

    @Override
    public PageVO<MessageVO> getMessageListWithPage(int page, int pageSize) {
        // 分页查询留言（type=1）
        LambdaQueryWrapper<Message> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Message::getType, 1)
                .orderByDesc(Message::getCreatedAt);

        Page<Message> pageParam = PageUtils.createPage(page, pageSize);
        Page<Message> messagePage = messageMapper.selectPage(pageParam, wrapper);

        List<Message> messages = messagePage.getRecords();

        if (messages.isEmpty()) {
            return PageUtils.toPageVO(messagePage, new ArrayList<>());
        }

        // 获取留言ID列表
        List<Long> messageIds = messages.stream().map(Message::getId).collect(Collectors.toList());

        // 获取所有回复
        LambdaQueryWrapper<MessageReply> replyWrapper = new LambdaQueryWrapper<>();
        replyWrapper.in(MessageReply::getMessageId, messageIds)
                .orderByAsc(MessageReply::getCreatedAt);
        List<MessageReply> allReplies = messageReplyMapper.selectList(replyWrapper);

        // 获取所有相关用户
        Set<Long> userIds = new HashSet<>();
        messages.forEach(m -> userIds.add(m.getUserId()));
        allReplies.forEach(r -> {
            userIds.add(r.getUserId());
            if (r.getReplyToUserId() != null) {
                userIds.add(r.getReplyToUserId());
            }
        });
        List<User> users = userMapper.selectBatchIds(userIds);
        Map<Long, User> userMap = users.stream().collect(Collectors.toMap(User::getId, u -> u));

        // 组装返回数据
        List<MessageVO> result = new ArrayList<>();
        for (Message msg : messages) {
            MessageVO vo = new MessageVO();
            vo.setId(msg.getId());
            vo.setContent(msg.getContent());
            vo.setImages(parseImages(msg.getImages()));
            vo.setDate(msg.getCreatedAt().format(DATE_FORMATTER));
            vo.setUser(buildUserVO(userMap.get(msg.getUserId())));

            // 获取该留言的回复
            List<MessageReply> replies = allReplies.stream()
                    .filter(r -> r.getMessageId().equals(msg.getId()))
                    .collect(Collectors.toList());

            List<MessageVO.ReplyVO> replyVOs = new ArrayList<>();
            for (MessageReply reply : replies) {
                MessageVO.ReplyVO replyVO = new MessageVO.ReplyVO();
                replyVO.setId(reply.getId());
                replyVO.setContent(reply.getContent());
                replyVO.setDate(reply.getCreatedAt().format(DATE_FORMATTER));
                replyVO.setUser(buildUserVO(userMap.get(reply.getUserId())));

                if (reply.getReplyToUserId() != null) {
                    User replyToUser = userMap.get(reply.getReplyToUserId());
                    if (replyToUser != null) {
                        replyVO.setReplyTo(replyToUser.getUsername());
                    }
                }
                replyVOs.add(replyVO);
            }
            vo.setReplies(replyVOs);
            result.add(vo);
        }

        return PageUtils.toPageVO(messagePage, result);
    }

    @Override
    @Transactional
    public MessageVO addMessage(Long userId, MessageRequest request) {
        Message message = new Message();
        message.setUserId(userId);
        message.setType(1); // 留言
        message.setContent(request.getContent());
        message.setImages(joinImages(request.getImages()));
        message.setLikes(0);
        message.setCreatedAt(LocalDateTime.now());
        messageMapper.insert(message);

        // 构建返回VO
        User user = userMapper.selectById(userId);
        MessageVO vo = new MessageVO();
        vo.setId(message.getId());
        vo.setContent(message.getContent());
        vo.setImages(request.getImages());
        vo.setDate(message.getCreatedAt().format(DATE_FORMATTER));
        vo.setUser(buildUserVO(user));
        vo.setReplies(new ArrayList<>());
        return vo;
    }

    @Override
    @Transactional
    public MessageVO.ReplyVO addReply(Long userId, MessageReplyRequest request) {
        MessageReply reply = new MessageReply();
        reply.setMessageId(request.getMessageId());
        reply.setUserId(userId);
        reply.setParentId(request.getParentId() != null ? request.getParentId() : 0L);
        reply.setReplyToUserId(request.getReplyToUserId());
        reply.setContent(request.getContent());
        reply.setCreatedAt(LocalDateTime.now());
        messageReplyMapper.insert(reply);

        // 构建返回VO
        User user = userMapper.selectById(userId);
        MessageVO.ReplyVO vo = new MessageVO.ReplyVO();
        vo.setId(reply.getId());
        vo.setContent(reply.getContent());
        vo.setDate(reply.getCreatedAt().format(DATE_FORMATTER));
        vo.setUser(buildUserVO(user));

        if (request.getReplyToUserId() != null) {
            User replyToUser = userMapper.selectById(request.getReplyToUserId());
            if (replyToUser != null) {
                vo.setReplyTo(replyToUser.getUsername());
            }
        }
        return vo;
    }

    private MessageVO.UserVO buildUserVO(User user) {
        if (user == null) {
            return null;
        }
        MessageVO.UserVO vo = new MessageVO.UserVO();
        vo.setId(user.getId());
        vo.setName(user.getUsername());
        vo.setAvatar(user.getAvatar());
        vo.setLevel(user.getLevel());
        vo.setTitle(user.getTitle());
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
}
