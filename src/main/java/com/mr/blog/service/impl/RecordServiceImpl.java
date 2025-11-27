package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.PageVO;
import com.mr.blog.dto.RecordCategoryVO;
import com.mr.blog.dto.RecordQueryRequest;
import com.mr.blog.dto.RecordVO;
import com.mr.blog.entity.Record;
import com.mr.blog.entity.RecordCategory;
import com.mr.blog.entity.RecordLike;
import com.mr.blog.entity.RecordTag;
import com.mr.blog.mapper.*;
import com.mr.blog.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 记录服务实现类
 */
@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    private RecordMapper recordMapper;

    @Autowired
    private RecordCategoryMapper categoryMapper;

    @Autowired
    private RecordTagMapper tagMapper;

    @Autowired
    private RecordLikeMapper likeMapper;

    @Override
    public PageVO<RecordVO> getRecordList(RecordQueryRequest request) {
        Page<RecordVO> page = new Page<>(request.getPage(), request.getPageSize());

        IPage<RecordVO> result = recordMapper.selectRecordPage(
                page,
                request.getCategory(),
                request.getSubCategory(),
                request.getTag(),
                request.getKeyword(),
                request.getSortBy());

        // 为每条记录查询标签
        for (RecordVO record : result.getRecords()) {
            List<RecordTag> tags = tagMapper.selectByRecordId(record.getId());
            record.setTags(tags.stream().map(RecordTag::getName).collect(Collectors.toList()));
        }

        return PageVO.of(
                result.getRecords(),
                result.getTotal(),
                (int) result.getCurrent(),
                (int) result.getSize());
    }

    @Override
    public RecordVO getRecordById(Long id) {
        RecordVO record = recordMapper.selectRecordById(id);
        if (record != null) {
            // 查询标签
            List<RecordTag> tags = tagMapper.selectByRecordId(id);
            record.setTags(tags.stream().map(RecordTag::getName).collect(Collectors.toList()));
        }
        return record;
    }

    @Override
    public void incrementViews(Long id) {
        recordMapper.incrementViews(id);
    }

    @Override
    @Transactional
    public boolean toggleLike(Long recordId, Long userId, String ipAddress) {
        // 检查是否已点赞
        QueryWrapper<RecordLike> wrapper = new QueryWrapper<>();
        wrapper.eq("record_id", recordId);
        if (userId != null) {
            wrapper.eq("user_id", userId);
        } else {
            wrapper.eq("ip_address", ipAddress);
        }

        RecordLike existingLike = likeMapper.selectOne(wrapper);

        if (existingLike != null) {
            // 取消点赞
            likeMapper.deleteById(existingLike.getId());
            recordMapper.decrementLikes(recordId);
            return false;
        } else {
            // 添加点赞
            RecordLike like = new RecordLike();
            like.setRecordId(recordId);
            like.setUserId(userId);
            like.setIpAddress(ipAddress);
            likeMapper.insert(like);
            recordMapper.incrementLikes(recordId);
            return true;
        }
    }

    @Override
    public boolean hasLiked(Long recordId, Long userId, String ipAddress) {
        if (userId != null) {
            return likeMapper.countByRecordAndUser(recordId, userId) > 0;
        } else if (ipAddress != null) {
            return likeMapper.countByRecordAndIp(recordId, ipAddress) > 0;
        }
        return false;
    }

    @Override
    public List<RecordCategoryVO> getCategories() {
        List<RecordCategoryVO> result = new ArrayList<>();

        // 添加"全部"分类
        RecordCategoryVO allCategory = new RecordCategoryVO();
        allCategory.setKey("all");
        allCategory.setName("全部");
        allCategory.setIcon("📚");
        allCategory.setCount(getTotalCount());
        result.add(allCategory);

        // 获取一级分类
        List<RecordCategory> parentCategories = categoryMapper.selectParentCategories();

        for (RecordCategory parent : parentCategories) {
            RecordCategoryVO vo = new RecordCategoryVO();
            vo.setId(parent.getId());
            vo.setKey(parent.getCategoryKey());
            vo.setName(parent.getName());
            vo.setIcon(parent.getIcon());
            vo.setParentId(null);
            vo.setCount(recordMapper.countByCategory(parent.getCategoryKey()));
            result.add(vo);
        }

        return result;
    }

    @Override
    public Map<String, List<RecordCategoryVO>> getSubCategoryMap() {
        Map<String, List<RecordCategoryVO>> result = new HashMap<>();

        // 获取一级分类
        List<RecordCategory> parentCategories = categoryMapper.selectParentCategories();

        for (RecordCategory parent : parentCategories) {
            List<RecordCategory> subCategories = categoryMapper.selectByParentId(parent.getId());

            List<RecordCategoryVO> subVOList = subCategories.stream().map(sub -> {
                RecordCategoryVO vo = new RecordCategoryVO();
                vo.setId(sub.getId());
                vo.setKey(sub.getCategoryKey());
                vo.setName(sub.getName());
                vo.setParentId(parent.getId());
                return vo;
            }).collect(Collectors.toList());

            result.put(parent.getCategoryKey(), subVOList);
        }

        return result;
    }

    @Override
    public List<String> getHotTags(int limit) {
        List<RecordTag> tags = tagMapper.selectHotTags(limit);
        return tags.stream().map(RecordTag::getName).collect(Collectors.toList());
    }

    @Override
    public int getTotalCount() {
        QueryWrapper<Record> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1);
        return Math.toIntExact(recordMapper.selectCount(wrapper));
    }
}
