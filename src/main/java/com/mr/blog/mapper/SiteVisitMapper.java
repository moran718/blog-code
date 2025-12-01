package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.SiteVisit;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * 网站访问统计Mapper
 */
@Mapper
public interface SiteVisitMapper extends BaseMapper<SiteVisit> {

    /**
     * 获取总访问量
     */
    @Select("SELECT COALESCE(SUM(visit_count), 0) FROM site_visit")
    Long getTotalVisitCount();
}

