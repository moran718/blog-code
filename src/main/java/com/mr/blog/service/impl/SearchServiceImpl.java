package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.dto.SearchResultVO;
import com.mr.blog.entity.Essay;
import com.mr.blog.entity.Music;
import com.mr.blog.entity.Record;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.EssayMapper;
import com.mr.blog.mapper.MusicMapper;
import com.mr.blog.mapper.RecordMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 全站搜索服务实现
 */
@Service
public class SearchServiceImpl implements SearchService {

    @Autowired
    private RecordMapper recordMapper;

    @Autowired
    private EssayMapper essayMapper;

    @Autowired
    private MusicMapper musicMapper;

    @Autowired
    private UserMapper userMapper;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    public SearchResultVO search(String keyword, String type, int limit) {
        SearchResultVO result = new SearchResultVO();
        result.setRecords(new ArrayList<>());
        result.setEssays(new ArrayList<>());
        result.setMusics(new ArrayList<>());

        int total = 0;

        // 搜索文章
        if ("all".equals(type) || "record".equals(type)) {
            List<SearchResultVO.RecordItem> records = searchRecords(keyword, limit);
            result.setRecords(records);
            total += records.size();
        }

        // 搜索随笔
        if ("all".equals(type) || "essay".equals(type)) {
            List<SearchResultVO.EssayItem> essays = searchEssays(keyword, limit);
            result.setEssays(essays);
            total += essays.size();
        }

        // 搜索音乐
        if ("all".equals(type) || "music".equals(type)) {
            List<SearchResultVO.MusicItem> musics = searchMusics(keyword, limit);
            result.setMusics(musics);
            total += musics.size();
        }

        result.setTotal(total);
        return result;
    }

    /**
     * 搜索文章
     */
    private List<SearchResultVO.RecordItem> searchRecords(String keyword, int limit) {
        LambdaQueryWrapper<Record> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Record::getStatus, 1)
                .and(w -> w.like(Record::getTitle, keyword)
                        .or().like(Record::getSummary, keyword)
                        .or().like(Record::getContent, keyword))
                .orderByDesc(Record::getCreatedAt)
                .last("LIMIT " + limit);

        List<Record> records = recordMapper.selectList(wrapper);
        List<SearchResultVO.RecordItem> items = new ArrayList<>();

        for (Record record : records) {
            SearchResultVO.RecordItem item = new SearchResultVO.RecordItem();
            item.setId(record.getId());
            item.setTitle(record.getTitle());
            item.setSummary(truncate(record.getSummary(), 100));
            item.setCover(record.getCover());
            item.setDate(record.getCreatedAt().format(DATE_FORMATTER));
            item.setViews(record.getViews());
            items.add(item);
        }

        return items;
    }

    /**
     * 搜索随笔
     */
    private List<SearchResultVO.EssayItem> searchEssays(String keyword, int limit) {
        LambdaQueryWrapper<Essay> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(Essay::getContent, keyword)
                .orderByDesc(Essay::getCreatedAt)
                .last("LIMIT " + limit);

        List<Essay> essays = essayMapper.selectList(wrapper);
        
        if (essays.isEmpty()) {
            return new ArrayList<>();
        }

        // 获取用户信息
        Set<Long> userIds = essays.stream()
                .map(Essay::getUserId)
                .collect(Collectors.toSet());
        List<User> users = userMapper.selectBatchIds(userIds);
        Map<Long, User> userMap = users.stream()
                .collect(Collectors.toMap(User::getId, u -> u));

        List<SearchResultVO.EssayItem> items = new ArrayList<>();
        for (Essay essay : essays) {
            SearchResultVO.EssayItem item = new SearchResultVO.EssayItem();
            item.setId(essay.getId());
            item.setContent(truncate(essay.getContent(), 100));
            item.setDate(essay.getCreatedAt().format(DATE_FORMATTER));

            User user = userMap.get(essay.getUserId());
            if (user != null) {
                item.setUserName(user.getUsername());
                item.setUserAvatar(user.getAvatar());
            }
            items.add(item);
        }

        return items;
    }

    /**
     * 搜索音乐
     */
    private List<SearchResultVO.MusicItem> searchMusics(String keyword, int limit) {
        LambdaQueryWrapper<Music> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Music::getStatus, 1)
                .and(w -> w.like(Music::getName, keyword)
                        .or().like(Music::getArtist, keyword)
                        .or().like(Music::getAlbum, keyword))
                .orderByAsc(Music::getSortOrder)
                .last("LIMIT " + limit);

        List<Music> musics = musicMapper.selectList(wrapper);
        List<SearchResultVO.MusicItem> items = new ArrayList<>();

        for (Music music : musics) {
            SearchResultVO.MusicItem item = new SearchResultVO.MusicItem();
            item.setId(music.getId());
            item.setName(music.getName());
            item.setArtist(music.getArtist());
            item.setAlbum(music.getAlbum());
            item.setCover(music.getCover());
            items.add(item);
        }

        return items;
    }

    /**
     * 截断文本
     */
    private String truncate(String text, int maxLength) {
        if (text == null) {
            return "";
        }
        if (text.length() <= maxLength) {
            return text;
        }
        return text.substring(0, maxLength) + "...";
    }
}

