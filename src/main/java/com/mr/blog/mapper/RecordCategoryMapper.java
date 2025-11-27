package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.RecordCategory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 记录分类Mapper接口
 */
@Mapper
public interface RecordCategoryMapper extends BaseMapper<RecordCategory> {
    
    /**
     * 查询所有一级分类
     */
    @Select("SELECT * FROM record_category WHERE parent_id IS NULL ORDER BY sort_order")
    List<RecordCategory> selectParentCategories();
    
    /**
     * 根据父分类ID查询子分类
     */
    @Select("SELECT * FROM record_category WHERE parent_id = #{parentId} ORDER BY sort_order")
    List<RecordCategory> selectByParentId(Long parentId);
    
    /**
     * 根据分类key查询分类
     */
    @Select("SELECT * FROM record_category WHERE category_key = #{categoryKey}")
    RecordCategory selectByCategoryKey(String categoryKey);
}

