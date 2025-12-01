package com.mr.blog.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.common.Result;
import com.mr.blog.dto.RecordVO;
import com.mr.blog.entity.EssayComment;
import com.mr.blog.entity.Record;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.EssayCommentMapper;
import com.mr.blog.mapper.RecordMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.SiteVisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * 仪表盘控制器
 */
@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin
public class DashboardController {

    @Autowired
    private RecordMapper recordMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private EssayCommentMapper essayCommentMapper;

    @Autowired
    private SiteVisitService siteVisitService;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    /**
     * 获取仪表盘统计数据
     */
    @GetMapping("/stats")
    public Result<Map<String, Object>> getStats() {
        Map<String, Object> stats = new HashMap<>();

        // 1. 文章总数（已发布）
        LambdaQueryWrapper<Record> recordWrapper = new LambdaQueryWrapper<>();
        recordWrapper.eq(Record::getStatus, 1);
        long articleCount = recordMapper.selectCount(recordWrapper);
        stats.put("articleCount", articleCount);

        // 2. 总访问量
        long totalViews = siteVisitService.getTotalVisitCount();
        stats.put("totalViews", totalViews);

        // 3. 评论总数（随笔评论）
        long commentCount = essayCommentMapper.selectCount(null);
        stats.put("commentCount", commentCount);

        // 4. 用户总数
        long userCount = userMapper.selectCount(null);
        stats.put("userCount", userCount);

        return Result.success(stats);
    }

    /**
     * 获取网站公开统计数据（用于页脚展示）
     */
    @GetMapping("/site-stats")
    public Result<Map<String, Object>> getSiteStats() {
        Map<String, Object> stats = new HashMap<>();

        // 1. 文章总数（已发布）
        LambdaQueryWrapper<Record> recordWrapper = new LambdaQueryWrapper<>();
        recordWrapper.eq(Record::getStatus, 1);
        long articleCount = recordMapper.selectCount(recordWrapper);
        stats.put("articles", articleCount);

        // 2. 总访问量
        long totalViews = siteVisitService.getTotalVisitCount();
        stats.put("totalViews", formatNumber(totalViews));

        // 3. 今日访客
        long todayViews = siteVisitService.getTodayVisitCount();
        stats.put("todayViews", todayViews);

        // 4. 运行天数（从2024-01-01开始，可以修改为实际日期）
        java.time.LocalDate startDate = java.time.LocalDate.of(2025, 11, 26);
        long runDays = java.time.temporal.ChronoUnit.DAYS.between(startDate, java.time.LocalDate.now());
        stats.put("runDays", runDays);

        return Result.success(stats);
    }

    /**
     * 格式化数字（如 12500 -> 1.2w）
     */
    private String formatNumber(long num) {
        if (num >= 10000) {
            double wan = num / 10000.0;
            return String.format("%.1fw", wan);
        }
        return String.valueOf(num);
    }

    /**
     * 获取最近文章
     */
    @GetMapping("/recent-articles")
    public Result<List<Map<String, Object>>> getRecentArticles(
            @RequestParam(defaultValue = "5") Integer limit) {

        List<RecordVO> records = recordMapper.selectLatestRecords(limit);
        List<Map<String, Object>> result = new ArrayList<>();

        for (RecordVO record : records) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", record.getId());
            item.put("title", record.getTitle());
            item.put("views", record.getViews());
            item.put("createdAt", record.getCreatedAt());
            result.add(item);
        }

        return Result.success(result);
    }

    /**
     * 获取最近评论
     */
    @GetMapping("/recent-comments")
    public Result<List<Map<String, Object>>> getRecentComments(
            @RequestParam(defaultValue = "5") Integer limit) {

        // 查询最近评论
        LambdaQueryWrapper<EssayComment> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByDesc(EssayComment::getCreatedAt)
                .last("LIMIT " + limit);
        List<EssayComment> comments = essayCommentMapper.selectList(wrapper);

        // 获取用户信息
        Set<Long> userIds = new HashSet<>();
        for (EssayComment comment : comments) {
            userIds.add(comment.getUserId());
        }

        Map<Long, User> userMap = new HashMap<>();
        if (!userIds.isEmpty()) {
            List<User> users = userMapper.selectBatchIds(userIds);
            for (User user : users) {
                userMap.put(user.getId(), user);
            }
        }

        // 组装结果
        List<Map<String, Object>> result = new ArrayList<>();
        for (EssayComment comment : comments) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", comment.getId());

            User user = userMap.get(comment.getUserId());
            item.put("username", user != null ? user.getUsername() : "未知用户");

            // 截取评论内容
            String content = comment.getContent();
            if (content != null && content.length() > 50) {
                content = content.substring(0, 50) + "...";
            }
            item.put("content", content);

            item.put("createdAt", comment.getCreatedAt() != null
                    ? comment.getCreatedAt().format(DATE_FORMATTER)
                    : "");
            result.add(item);
        }

        return Result.success(result);
    }
}
