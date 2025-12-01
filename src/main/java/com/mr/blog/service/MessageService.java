package com.mr.blog.service;

import com.mr.blog.dto.AdminMessageVO;
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

    // ==================== 管理端方法 ====================

    /**
     * 获取留言/弹幕列表（管理端，分页）
     *
     * @param page    页码
     * @param size    每页条数
     * @param keyword 关键词（搜索内容）
     * @param type    类型：0-弹幕，1-留言，null表示全部
     * @return 留言分页列表
     */
    PageVO<AdminMessageVO> getAdminMessageList(int page, int size, String keyword, Integer type);

    /**
     * 管理员删除留言/弹幕（同时删除其回复）
     *
     * @param id 留言ID
     */
    void deleteMessageByAdmin(Long id);
}
