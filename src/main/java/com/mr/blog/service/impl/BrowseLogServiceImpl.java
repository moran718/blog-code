package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.BrowseLog;
import com.mr.blog.mapper.BrowseLogMapper;
import com.mr.blog.service.BrowseLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * 浏览记录服务实现
 */
@Service
public class BrowseLogServiceImpl implements BrowseLogService {

    @Autowired
    private BrowseLogMapper browseLogMapper;

    @Override
    public void recordBrowse(String ip, String url, String userAgent, String referer) {
        // 查询是否已存在相同IP的记录
        LambdaQueryWrapper<BrowseLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BrowseLog::getIp, ip);
        BrowseLog existLog = browseLogMapper.selectOne(wrapper);

        if (existLog != null) {
            // 已存在，更新访问时间和其他信息
            existLog.setUrl(url);
            existLog.setUserAgent(userAgent);
            existLog.setReferer(referer);
            existLog.setCreatedAt(LocalDateTime.now());
            browseLogMapper.updateById(existLog);
        } else {
            // 不存在，新增记录
            BrowseLog browseLog = new BrowseLog();
            browseLog.setIp(ip);
            browseLog.setUrl(url);
            browseLog.setUserAgent(userAgent);
            browseLog.setReferer(referer);
            browseLog.setCreatedAt(LocalDateTime.now());
            browseLogMapper.insert(browseLog);
        }
    }

    @Override
    public PageVO<BrowseLog> getList(int page, int size, String ip) {
        Page<BrowseLog> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<BrowseLog> wrapper = new LambdaQueryWrapper<>();

        // 如果有IP搜索条件
        if (StringUtils.hasText(ip)) {
            wrapper.like(BrowseLog::getIp, ip);
        }

        // 按时间倒序排列
        wrapper.orderByDesc(BrowseLog::getCreatedAt);

        Page<BrowseLog> result = browseLogMapper.selectPage(pageParam, wrapper);
        return PageVO.of(result.getRecords(), result.getTotal(), page, size);
    }

    @Override
    public Long getTotalCount() {
        return browseLogMapper.selectCount(null);
    }

    @Override
    public Long getTodayCount() {
        LocalDateTime startOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MIN);
        LocalDateTime endOfDay = LocalDateTime.of(LocalDate.now(), LocalTime.MAX);

        LambdaQueryWrapper<BrowseLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.between(BrowseLog::getCreatedAt, startOfDay, endOfDay);

        return browseLogMapper.selectCount(wrapper);
    }

    @Override
    public void deleteById(Long id) {
        browseLogMapper.deleteById(id);
    }

    @Override
    public void clearAll() {
        browseLogMapper.delete(null);
    }
}
