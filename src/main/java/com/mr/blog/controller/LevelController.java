package com.mr.blog.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.common.Result;
import com.mr.blog.entity.Level;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.LevelMapper;
import com.mr.blog.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 等级管理控制器
 */
@RestController
@RequestMapping("/api/level")
@CrossOrigin
public class LevelController {

    @Autowired
    private LevelMapper levelMapper;

    @Autowired
    private UserMapper userMapper;

    /**
     * 获取所有等级列表
     */
    @GetMapping("/list")
    public Result<List<Level>> getLevelList() {
        List<Level> levels = levelMapper.selectList(
                new LambdaQueryWrapper<Level>().orderByAsc(Level::getId)
        );
        return Result.success(levels);
    }

    /**
     * 根据ID获取等级详情
     */
    @GetMapping("/{id}")
    public Result<Level> getLevelById(@PathVariable Integer id) {
        Level level = levelMapper.selectById(id);
        if (level == null) {
            return Result.error("等级不存在");
        }
        return Result.success(level);
    }

    /**
     * 添加等级
     */
    @PostMapping("/add")
    public Result<Integer> addLevel(@RequestBody Level level) {
        // 检查ID是否已存在
        Level existing = levelMapper.selectById(level.getId());
        if (existing != null) {
            return Result.error("等级ID已存在");
        }
        
        // 检查名称是否已存在
        LambdaQueryWrapper<Level> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Level::getName, level.getName());
        if (levelMapper.selectOne(wrapper) != null) {
            return Result.error("等级名称已存在");
        }
        
        levelMapper.insert(level);
        return Result.success(level.getId());
    }

    /**
     * 更新等级
     */
    @PutMapping("/update")
    public Result<Void> updateLevel(@RequestBody Level level) {
        if (level.getId() == null) {
            return Result.error("等级ID不能为空");
        }
        
        Level existing = levelMapper.selectById(level.getId());
        if (existing == null) {
            return Result.error("等级不存在");
        }
        
        // 检查名称是否与其他等级重复
        LambdaQueryWrapper<Level> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Level::getName, level.getName())
               .ne(Level::getId, level.getId());
        if (levelMapper.selectOne(wrapper) != null) {
            return Result.error("等级名称已存在");
        }
        
        levelMapper.updateById(level);
        return Result.success();
    }

    /**
     * 删除等级
     */
    @DeleteMapping("/delete/{id}")
    public Result<Void> deleteLevel(@PathVariable Integer id) {
        Level level = levelMapper.selectById(id);
        if (level == null) {
            return Result.error("等级不存在");
        }
        
        // 检查是否有用户使用该等级
        LambdaQueryWrapper<User> userWrapper = new LambdaQueryWrapper<>();
        userWrapper.eq(User::getLevelId, id);
        Long userCount = userMapper.selectCount(userWrapper);
        if (userCount > 0) {
            return Result.error("有 " + userCount + " 个用户使用该等级，无法删除");
        }
        
        levelMapper.deleteById(id);
        return Result.success();
    }

    /**
     * 获取使用该等级的用户数量
     */
    @GetMapping("/{id}/user-count")
    public Result<Long> getLevelUserCount(@PathVariable Integer id) {
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getLevelId, id);
        Long count = userMapper.selectCount(wrapper);
        return Result.success(count);
    }
}

