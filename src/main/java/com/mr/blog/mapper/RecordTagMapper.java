package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.RecordTag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 标签Mapper接口
 */
@Mapper
public interface RecordTagMapper extends BaseMapper<RecordTag> {
    
    /**
     * 查询热门标签（按使用次数排序）
     */
    @Select("SELECT * FROM record_tag ORDER BY use_count DESC LIMIT #{limit}")
    List<RecordTag> selectHotTags(@Param("limit") int limit);
    
    /**
     * 根据记录ID查询标签列表
     */
    @Select("SELECT t.* FROM record_tag t " +
            "INNER JOIN record_tag_relation r ON t.id = r.tag_id " +
            "WHERE r.record_id = #{recordId}")
    List<RecordTag> selectByRecordId(@Param("recordId") Long recordId);
    
    /**
     * 根据标签名称查询标签
     */
    @Select("SELECT * FROM record_tag WHERE name = #{name}")
    RecordTag selectByName(@Param("name") String name);
    
    /**
     * 增加标签使用次数
     */
    @Update("UPDATE record_tag SET use_count = use_count + 1 WHERE id = #{id}")
    int incrementUseCount(@Param("id") Long id);
    
    /**
     * 减少标签使用次数
     */
    @Update("UPDATE record_tag SET use_count = use_count - 1 WHERE id = #{id} AND use_count > 0")
    int decrementUseCount(@Param("id") Long id);
}

