package com.mr.blog.service;

import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.BrowseLog;

/**
 * 浏览记录服务接口
 */
public interface BrowseLogService {

    /**
     * 记录一次浏览
     * @param ip IP地址
     * @param url 访问的URL
     * @param userAgent 浏览器User-Agent
     * @param referer 来源页面
     */
    void recordBrowse(String ip, String url, String userAgent, String referer);

    /**
     * 分页查询浏览记录
     * @param page 页码
     * @param size 每页条数
     * @param ip IP地址（可选，用于搜索）
     * @return 分页结果
     */
    PageVO<BrowseLog> getList(int page, int size, String ip);

    /**
     * 获取总浏览次数
     * @return 浏览次数
     */
    Long getTotalCount();

    /**
     * 获取今日浏览次数
     * @return 今日浏览次数
     */
    Long getTodayCount();

    /**
     * 删除浏览记录
     * @param id 记录ID
     */
    void deleteById(Long id);

    /**
     * 清空所有浏览记录
     */
    void clearAll();
}

