package com.mr.blog.service;

import com.mr.blog.dto.CommentRequest;
import com.mr.blog.dto.EssayRequest;
import com.mr.blog.dto.EssayVO;
import com.mr.blog.dto.PageVO;

public interface EssayService {

    /**
     * 获取随笔列表（分页）
     */
    PageVO<EssayVO> getEssayListWithPage(int page, int size);

    /**
     * 发布随笔
     */
    void publishEssay(Long userId, EssayRequest request);

    /**
     * 删除随笔
     */
    void deleteEssay(Long userId, Long essayId);

    /**
     * 发表评论，返回新创建的评论VO
     */
    EssayVO.CommentVO addComment(Long userId, CommentRequest request);

    /**
     * 删除评论
     */
    void deleteComment(Long userId, Long commentId);

    /**
     * 获取随笔评论列表（分页）
     */
    PageVO<EssayVO.CommentVO> getEssayComments(Long essayId, int page, int pageSize);
}
