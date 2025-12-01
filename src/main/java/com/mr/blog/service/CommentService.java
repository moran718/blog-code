package com.mr.blog.service;

import com.mr.blog.dto.AdminCommentVO;
import com.mr.blog.dto.PageVO;

/**
 * 随笔评论管理服务接口
 */
public interface CommentService {

    /**
     * 获取随笔评论列表（分页）
     *
     * @param page    页码
     * @param size    每页条数
     * @param keyword 关键词（搜索评论内容）
     * @return 评论分页列表
     */
    PageVO<AdminCommentVO> getAdminCommentList(int page, int size, String keyword);

    /**
     * 管理员删除随笔评论
     *
     * @param id 评论ID
     */
    void deleteCommentByAdmin(Long id);
}
