package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.RecordVO;
import com.mr.blog.entity.Record;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 记录Mapper接口
 */
@Mapper
public interface RecordMapper extends BaseMapper<Record> {
    
    /**
     * 分页查询记录（带分类和标签信息）
     */
    IPage<RecordVO> selectRecordPage(
            Page<RecordVO> page,
            @Param("category") String category,
            @Param("subCategory") String subCategory,
            @Param("tag") String tag,
            @Param("keyword") String keyword,
            @Param("sortBy") String sortBy
    );
    
    /**
     * 根据ID查询记录详情
     */
    RecordVO selectRecordById(@Param("id") Long id);
    
    /**
     * 增加浏览量
     */
    @Update("UPDATE record SET views = views + 1 WHERE id = #{id}")
    int incrementViews(@Param("id") Long id);
    
    /**
     * 增加点赞数
     */
    @Update("UPDATE record SET likes = likes + 1 WHERE id = #{id}")
    int incrementLikes(@Param("id") Long id);
    
    /**
     * 减少点赞数
     */
    @Update("UPDATE record SET likes = likes - 1 WHERE id = #{id} AND likes > 0")
    int decrementLikes(@Param("id") Long id);
    
    /**
     * 统计分类下的记录数量
     */
    @Select("SELECT COUNT(*) FROM record r " +
            "INNER JOIN record_category c ON r.category_id = c.id " +
            "INNER JOIN record_category p ON c.parent_id = p.id " +
            "WHERE p.category_key = #{categoryKey} AND r.status = 1")
    int countByCategory(@Param("categoryKey") String categoryKey);
    
    /**
     * 统计子分类下的记录数量
     */
    @Select("SELECT COUNT(*) FROM record r " +
            "INNER JOIN record_category c ON r.category_id = c.id " +
            "WHERE c.category_key = #{subCategoryKey} AND r.status = 1")
    int countBySubCategory(@Param("subCategoryKey") String subCategoryKey);
}

