package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.Music;
import org.apache.ibatis.annotations.Mapper;

/**
 * 音乐Mapper接口
 */
@Mapper
public interface MusicMapper extends BaseMapper<Music> {
}

