package com.mr.blog.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.common.Result;
import com.mr.blog.dto.CategoryRequest;
import com.mr.blog.dto.CategoryTreeVO;
import com.mr.blog.entity.Record;
import com.mr.blog.entity.RecordCategory;
import com.mr.blog.mapper.RecordCategoryMapper;
import com.mr.blog.mapper.RecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 分类管理控制器
 */
@RestController
@RequestMapping("/api/category")
@CrossOrigin
public class CategoryController {

    @Autowired
    private RecordCategoryMapper categoryMapper;

    @Autowired
    private RecordMapper recordMapper;

    /**
     * 获取分类树形结构
     */
    @GetMapping("/tree")
    public Result<List<CategoryTreeVO>> getCategoryTree() {
        // 获取所有分类
        List<RecordCategory> allCategories = categoryMapper.selectList(
                new LambdaQueryWrapper<RecordCategory>().orderByAsc(RecordCategory::getSortOrder)
        );

        // 构建树形结构
        List<CategoryTreeVO> tree = buildTree(allCategories);
        return Result.success(tree);
    }

    /**
     * 获取所有分类（平铺列表）
     */
    @GetMapping("/list")
    public Result<List<RecordCategory>> getCategoryList() {
        List<RecordCategory> categories = categoryMapper.selectList(
                new LambdaQueryWrapper<RecordCategory>().orderByAsc(RecordCategory::getSortOrder)
        );
        return Result.success(categories);
    }

    /**
     * 添加分类
     */
    @PostMapping("/add")
    public Result<Long> addCategory(@RequestBody CategoryRequest request) {
        RecordCategory category = new RecordCategory();
        category.setName(request.getName());
        category.setCategoryKey(generateCategoryKey(request.getName()));
        category.setIcon(request.getIcon());
        category.setParentId(request.getParentId());
        category.setSortOrder(request.getSort() != null ? request.getSort() : 0);
        category.setCreatedAt(LocalDateTime.now());
        category.setUpdatedAt(LocalDateTime.now());
        categoryMapper.insert(category);
        return Result.success(category.getId());
    }

    /**
     * 更新分类
     */
    @PutMapping("/update")
    public Result<Void> updateCategory(@RequestBody CategoryRequest request) {
        RecordCategory category = categoryMapper.selectById(request.getId());
        if (category == null) {
            return Result.error("分类不存在");
        }
        category.setName(request.getName());
        if (request.getCategoryKey() != null) {
            category.setCategoryKey(request.getCategoryKey());
        }
        if (request.getIcon() != null) {
            category.setIcon(request.getIcon());
        }
        if (request.getSort() != null) {
            category.setSortOrder(request.getSort());
        }
        category.setUpdatedAt(LocalDateTime.now());
        categoryMapper.updateById(category);
        return Result.success(null);
    }

    /**
     * 删除分类
     */
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteCategory(@PathVariable Long id) {
        // 检查是否有子分类
        Long childCount = categoryMapper.selectCount(
                new LambdaQueryWrapper<RecordCategory>().eq(RecordCategory::getParentId, id)
        );
        if (childCount > 0) {
            return Result.error("该分类下有子分类，无法删除");
        }

        // 检查是否有文章使用该分类
        Long articleCount = recordMapper.selectCount(
                new LambdaQueryWrapper<Record>().eq(Record::getCategoryId, id)
        );
        if (articleCount > 0) {
            return Result.error("该分类下有文章，无法删除");
        }

        categoryMapper.deleteById(id);
        return Result.success(null);
    }

    /**
     * 构建分类树形结构
     */
    private List<CategoryTreeVO> buildTree(List<RecordCategory> categories) {
        // 找出一级分类
        List<RecordCategory> parents = categories.stream()
                .filter(c -> c.getParentId() == null || c.getParentId() == 0)
                .collect(Collectors.toList());

        List<CategoryTreeVO> tree = new ArrayList<>();
        for (RecordCategory parent : parents) {
            CategoryTreeVO vo = convertToVO(parent);
            // 查找子分类
            List<CategoryTreeVO> children = categories.stream()
                    .filter(c -> parent.getId().equals(c.getParentId()))
                    .map(this::convertToVO)
                    .collect(Collectors.toList());
            vo.setChildren(children.isEmpty() ? null : children);
            tree.add(vo);
        }
        return tree;
    }

    /**
     * 转换为VO
     */
    private CategoryTreeVO convertToVO(RecordCategory category) {
        CategoryTreeVO vo = new CategoryTreeVO();
        vo.setId(category.getId());
        vo.setName(category.getName());
        vo.setCategoryKey(category.getCategoryKey());
        vo.setIcon(category.getIcon());
        vo.setParentId(category.getParentId());
        vo.setSortOrder(category.getSortOrder());
        // 统计该分类下的文章数
        Long count = recordMapper.selectCount(
                new LambdaQueryWrapper<Record>().eq(Record::getCategoryId, category.getId())
        );
        vo.setArticleCount(count.intValue());
        return vo;
    }

    /**
     * 生成分类key（简单的拼音或英文转换）
     */
    private String generateCategoryKey(String name) {
        // 简单处理：使用时间戳+名称hashcode
        return "cat_" + System.currentTimeMillis() % 10000;
    }
}

