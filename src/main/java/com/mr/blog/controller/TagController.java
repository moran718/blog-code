package com.mr.blog.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.common.Result;
import com.mr.blog.entity.RecordTag;
import com.mr.blog.entity.RecordTagRelation;
import com.mr.blog.mapper.RecordTagMapper;
import com.mr.blog.mapper.RecordTagRelationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 标签管理控制器
 */
@RestController
@RequestMapping("/api/tag")
@CrossOrigin(origins = {"http://localhost:8081", "http://localhost:8888"}, allowCredentials = "true")
public class TagController {

    @Autowired
    private RecordTagMapper tagMapper;

    @Autowired
    private RecordTagRelationMapper tagRelationMapper;

    /**
     * 获取标签列表（分页）
     */
    @GetMapping("/list")
    public Result<Map<String, Object>> getTagList(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        
        Page<RecordTag> pageParam = new Page<>(page, size);
        IPage<RecordTag> result = tagMapper.selectPage(pageParam, 
                new LambdaQueryWrapper<RecordTag>().orderByDesc(RecordTag::getUseCount));
        
        Map<String, Object> data = new HashMap<>();
        data.put("records", result.getRecords());
        data.put("total", result.getTotal());
        data.put("page", result.getCurrent());
        data.put("size", result.getSize());
        
        return Result.success(data);
    }

    /**
     * 获取所有标签（不分页）
     */
    @GetMapping("/all")
    public Result<List<RecordTag>> getAllTags() {
        List<RecordTag> tags = tagMapper.selectList(
                new LambdaQueryWrapper<RecordTag>().orderByDesc(RecordTag::getUseCount)
        );
        return Result.success(tags);
    }

    /**
     * 添加标签
     */
    @PostMapping("/add")
    public Result<Long> addTag(@RequestBody RecordTag tag) {
        // 检查标签名是否已存在
        RecordTag existing = tagMapper.selectByName(tag.getName());
        if (existing != null) {
            return Result.error("标签名称已存在");
        }
        
        tag.setUseCount(0);
        tag.setCreatedAt(LocalDateTime.now());
        if (tag.getColor() == null || tag.getColor().isEmpty()) {
            tag.setColor("#409EFF");
        }
        tagMapper.insert(tag);
        return Result.success(tag.getId());
    }

    /**
     * 更新标签
     */
    @PutMapping("/update")
    public Result<Void> updateTag(@RequestBody RecordTag tag) {
        RecordTag existing = tagMapper.selectById(tag.getId());
        if (existing == null) {
            return Result.error("标签不存在");
        }
        
        // 检查新名称是否与其他标签冲突
        RecordTag nameCheck = tagMapper.selectByName(tag.getName());
        if (nameCheck != null && !nameCheck.getId().equals(tag.getId())) {
            return Result.error("标签名称已存在");
        }
        
        existing.setName(tag.getName());
        if (tag.getColor() != null) {
            existing.setColor(tag.getColor());
        }
        tagMapper.updateById(existing);
        return Result.success(null);
    }

    /**
     * 删除标签
     */
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteTag(@PathVariable Long id) {
        // 检查是否有文章使用该标签
        Long relationCount = tagRelationMapper.selectCount(
                new LambdaQueryWrapper<RecordTagRelation>().eq(RecordTagRelation::getTagId, id)
        );
        if (relationCount > 0) {
            return Result.error("该标签下有文章，无法删除。请先移除相关文章的该标签");
        }
        
        tagMapper.deleteById(id);
        return Result.success(null);
    }

    /**
     * 根据ID获取标签
     */
    @GetMapping("/{id}")
    public Result<RecordTag> getTagById(@PathVariable Long id) {
        RecordTag tag = tagMapper.selectById(id);
        if (tag == null) {
            return Result.error("标签不存在");
        }
        return Result.success(tag);
    }
}

