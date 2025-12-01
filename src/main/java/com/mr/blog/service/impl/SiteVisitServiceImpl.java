package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.mr.blog.entity.SiteVisit;
import com.mr.blog.mapper.SiteVisitMapper;
import com.mr.blog.service.SiteVisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

/**
 * 网站访问统计服务实现
 */
@Service
public class SiteVisitServiceImpl implements SiteVisitService {

    @Autowired
    private SiteVisitMapper siteVisitMapper;

    @Override
    public void recordVisit() {
        LocalDate today = LocalDate.now();

        // 尝试更新今日访问量
        LambdaUpdateWrapper<SiteVisit> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(SiteVisit::getVisitDate, today)
                .setSql("visit_count = visit_count + 1");
        int updated = siteVisitMapper.update(null, updateWrapper);

        // 如果今日记录不存在，则创建新记录
        if (updated == 0) {
            SiteVisit visit = new SiteVisit();
            visit.setVisitDate(today);
            visit.setVisitCount(1);
            try {
                siteVisitMapper.insert(visit);
            } catch (Exception e) {
                // 并发情况下可能插入失败，再次尝试更新
                siteVisitMapper.update(null, updateWrapper);
            }
        }
    }

    @Override
    public Long getTotalVisitCount() {
        return siteVisitMapper.getTotalVisitCount();
    }

    @Override
    public Long getTodayVisitCount() {
        LocalDate today = LocalDate.now();
        LambdaQueryWrapper<SiteVisit> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SiteVisit::getVisitDate, today);
        SiteVisit visit = siteVisitMapper.selectOne(wrapper);
        return visit != null ? Long.valueOf(visit.getVisitCount()) : 0L;
    }
}
