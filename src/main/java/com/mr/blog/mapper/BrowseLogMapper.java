package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.BrowseLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * 浏览记录Mapper
 */
@Mapper
public interface BrowseLogMapper extends BaseMapper<BrowseLog> {
}

