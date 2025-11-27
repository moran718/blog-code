package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.RecordTagRelation;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 记录-标签关联Mapper接口
 */
@Mapper
public interface RecordTagRelationMapper extends BaseMapper<RecordTagRelation> {
    
    /**
     * 删除记录的所有标签关联
     */
    @Delete("DELETE FROM record_tag_relation WHERE record_id = #{recordId}")
    int deleteByRecordId(@Param("recordId") Long recordId);
}

