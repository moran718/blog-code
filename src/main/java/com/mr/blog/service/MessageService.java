package com.mr.blog.service;

import com.mr.blog.dto.DanmakuVO;
import com.mr.blog.dto.MessageRequest;
import com.mr.blog.dto.MessageReplyRequest;
import com.mr.blog.dto.MessageVO;
import com.mr.blog.dto.PageVO;

import java.util.List;

public interface MessageService {

    /**
     * 获取弹幕列表
     */
    List<DanmakuVO> getDanmakuList(Long userId);

    /**
     * 发送弹幕
     */
    void sendDanmaku(Long userId, String content);

    /**
     * 切换弹幕点赞
     */
    boolean toggleLike(Long userId, Long messageId);

    /**
     * 获取留言列表
     */
    List<MessageVO> getMessageList();

    /**
     * 获取留言列表（分页）
     * 
     * @param page     页码（从1开始）
     * @param pageSize 每页条数
     * @return 分页结果
     */
    PageVO<MessageVO> getMessageListWithPage(int page, int pageSize);

    /**
     * 发布留言
     */
    MessageVO addMessage(Long userId, MessageRequest request);

    /**
     * 回复留言
     */
    MessageVO.ReplyVO addReply(Long userId, MessageReplyRequest request);
}
