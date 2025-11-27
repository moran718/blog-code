package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.RecordLike;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * 记录点赞Mapper接口
 */
@Mapper
public interface RecordLikeMapper extends BaseMapper<RecordLike> {
    
    /**
     * 查询用户是否已点赞
     */
    @Select("SELECT COUNT(*) FROM record_like WHERE record_id = #{recordId} AND user_id = #{userId}")
    int countByRecordAndUser(@Param("recordId") Long recordId, @Param("userId") Long userId);
    
    /**
     * 查询IP是否已点赞
     */
    @Select("SELECT COUNT(*) FROM record_like WHERE record_id = #{recordId} AND ip_address = #{ipAddress}")
    int countByRecordAndIp(@Param("recordId") Long recordId, @Param("ipAddress") String ipAddress);
}

