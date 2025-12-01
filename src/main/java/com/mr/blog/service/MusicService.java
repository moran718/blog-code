package com.mr.blog.service;

import com.mr.blog.dto.MusicVO;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.Music;

import java.util.List;

/**
 * 音乐服务接口
 */
public interface MusicService {

    /**
     * 获取所有启用的音乐列表
     */
    List<MusicVO> getMusicList();

    /**
     * 分页获取音乐列表（管理端）
     */
    PageVO<Music> getMusicListWithPage(int page, int size, String keyword);

    /**
     * 根据ID获取音乐
     */
    Music getMusicById(Long id);

    /**
     * 添加音乐
     */
    void addMusic(Music music);

    /**
     * 更新音乐
     */
    void updateMusic(Music music);

    /**
     * 删除音乐
     */
    void deleteMusic(Long id);

    /**
     * 更新音乐状态
     */
    void updateStatus(Long id, Integer status);
}

