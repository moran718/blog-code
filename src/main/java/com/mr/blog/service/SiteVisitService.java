package com.mr.blog.service;

/**
 * 网站访问统计服务
 */
public interface SiteVisitService {

    /**
     * 记录一次访问
     */
    void recordVisit();

    /**
     * 获取总访问量
     */
    Long getTotalVisitCount();

    /**
     * 获取今日访问量
     */
    Long getTodayVisitCount();
}
