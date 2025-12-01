package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.MusicVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.Music;
import com.mr.blog.mapper.MusicMapper;
import com.mr.blog.service.MusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * 音乐服务实现类
 */
@Service
public class MusicServiceImpl implements MusicService {

    @Autowired
    private MusicMapper musicMapper;

    @Override
    public List<MusicVO> getMusicList() {
        LambdaQueryWrapper<Music> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Music::getStatus, 1)
                .orderByAsc(Music::getSortOrder)
                .orderByDesc(Music::getCreatedAt);

        List<Music> musicList = musicMapper.selectList(wrapper);
        List<MusicVO> voList = new ArrayList<>();

        for (Music music : musicList) {
            voList.add(convertToVO(music));
        }

        return voList;
    }

    @Override
    public PageVO<Music> getMusicListWithPage(int page, int size, String keyword) {
        Page<Music> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Music> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.hasText(keyword)) {
            wrapper.and(w -> w.like(Music::getName, keyword)
                    .or().like(Music::getArtist, keyword)
                    .or().like(Music::getAlbum, keyword));
        }

        wrapper.orderByAsc(Music::getSortOrder)
                .orderByDesc(Music::getCreatedAt);

        Page<Music> result = musicMapper.selectPage(pageParam, wrapper);

        return PageVO.of(result.getRecords(), result.getTotal(), page, size);
    }

    @Override
    public Music getMusicById(Long id) {
        return musicMapper.selectById(id);
    }

    @Override
    public void addMusic(Music music) {
        music.setCreatedAt(LocalDateTime.now());
        music.setUpdatedAt(LocalDateTime.now());
        if (music.getStatus() == null) {
            music.setStatus(1);
        }
        if (music.getSortOrder() == null) {
            music.setSortOrder(0);
        }
        musicMapper.insert(music);
    }

    @Override
    public void updateMusic(Music music) {
        music.setUpdatedAt(LocalDateTime.now());
        musicMapper.updateById(music);
    }

    @Override
    public void deleteMusic(Long id) {
        musicMapper.deleteById(id);
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        Music music = new Music();
        music.setId(id);
        music.setStatus(status);
        music.setUpdatedAt(LocalDateTime.now());
        musicMapper.updateById(music);
    }

    /**
     * 转换为VO对象
     */
    private MusicVO convertToVO(Music music) {
        MusicVO vo = new MusicVO();
        vo.setId(music.getId());
        vo.setName(music.getName());
        vo.setArtist(music.getArtist());
        vo.setAlbum(music.getAlbum());
        vo.setCover(music.getCover());
        vo.setUrl(music.getUrl());
        vo.setDurationSeconds(music.getDuration());
        vo.setDuration(formatDuration(music.getDuration()));
        return vo;
    }

    /**
     * 格式化时长
     */
    private String formatDuration(Integer seconds) {
        if (seconds == null || seconds <= 0) {
            return "0:00";
        }
        int minutes = seconds / 60;
        int secs = seconds % 60;
        return String.format("%d:%02d", minutes, secs);
    }
}
