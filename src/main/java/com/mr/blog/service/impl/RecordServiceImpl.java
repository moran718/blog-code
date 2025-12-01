package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.*;
import com.mr.blog.entity.*;
import com.mr.blog.mapper.*;
import com.mr.blog.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
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

    @Autowired
    private RecordTagRelationMapper tagRelationMapper;

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
        QueryWrapper<com.mr.blog.entity.Record> wrapper = new QueryWrapper<>();
        wrapper.eq("status", 1);
        return Math.toIntExact(recordMapper.selectCount(wrapper));
    }

    @Override
    public List<RecordVO> getLatestRecords(int limit) {
        List<RecordVO> records = recordMapper.selectLatestRecords(limit);
        // 为每条记录查询标签
        for (RecordVO record : records) {
            List<RecordTag> tags = tagMapper.selectByRecordId(record.getId());
            record.setTags(tags.stream().map(RecordTag::getName).collect(Collectors.toList()));
        }
        return records;
    }

    @Override
    public List<RecordVO> getHotRecords(int limit) {
        List<RecordVO> records = recordMapper.selectHotRecords(limit);
        // 为每条记录查询标签
        for (RecordVO record : records) {
            List<RecordTag> tags = tagMapper.selectByRecordId(record.getId());
            record.setTags(tags.stream().map(RecordTag::getName).collect(Collectors.toList()));
        }
        return records;
    }

    @Override
    public List<ArchiveVO> getArchiveList() {
        // 查询所有已发布文章
        List<RecordVO> allRecords = recordMapper.selectAllForArchive();

        // 按年月分组
        Map<Integer, Map<Integer, List<RecordVO>>> yearMonthMap = new LinkedHashMap<>();

        for (RecordVO record : allRecords) {
            if (record.getCreatedAt() == null)
                continue;

            int year = record.getCreatedAt().getYear();
            int month = record.getCreatedAt().getMonthValue();

            yearMonthMap.computeIfAbsent(year, k -> new LinkedHashMap<>())
                    .computeIfAbsent(month, k -> new ArrayList<>())
                    .add(record);
        }

        // 转换为ArchiveVO列表
        List<ArchiveVO> result = new ArrayList<>();

        for (Map.Entry<Integer, Map<Integer, List<RecordVO>>> yearEntry : yearMonthMap.entrySet()) {
            ArchiveVO archiveVO = new ArchiveVO();
            archiveVO.setYear(yearEntry.getKey());

            List<ArchiveVO.ArchiveMonthVO> months = new ArrayList<>();
            int yearCount = 0;

            for (Map.Entry<Integer, List<RecordVO>> monthEntry : yearEntry.getValue().entrySet()) {
                ArchiveVO.ArchiveMonthVO monthVO = new ArchiveVO.ArchiveMonthVO();
                monthVO.setMonth(monthEntry.getKey());
                monthVO.setCount(monthEntry.getValue().size());
                yearCount += monthEntry.getValue().size();

                // 转换文章列表
                List<ArchiveVO.ArchiveRecordVO> archiveRecords = monthEntry.getValue().stream()
                        .map(record -> {
                            ArchiveVO.ArchiveRecordVO arVO = new ArchiveVO.ArchiveRecordVO();
                            arVO.setId(record.getId());
                            arVO.setTitle(record.getTitle());
                            arVO.setCover(record.getCover());
                            arVO.setCategoryName(record.getCategoryName());
                            arVO.setViews(record.getViews());
                            arVO.setLikes(record.getLikes());
                            // 格式化日期为 MM-dd
                            if (record.getCreatedAt() != null) {
                                arVO.setDate(String.format("%02d-%02d",
                                        record.getCreatedAt().getMonthValue(),
                                        record.getCreatedAt().getDayOfMonth()));
                            }
                            return arVO;
                        })
                        .collect(Collectors.toList());

                monthVO.setRecords(archiveRecords);
                months.add(monthVO);
            }

            archiveVO.setCount(yearCount);
            archiveVO.setMonths(months);
            result.add(archiveVO);
        }

        return result;
    }

    // ==================== 管理端接口实现 ====================

    @Override
    @Transactional
    public Long addArticle(ArticleRequest request, Long userId) {
        com.mr.blog.entity.Record record = new com.mr.blog.entity.Record();
        record.setTitle(request.getTitle());
        record.setSummary(request.getSummary());
        record.setContent(request.getContent());
        record.setCover(request.getCover());
        record.setCategoryId(request.getCategoryId());
        record.setUserId(userId);
        record.setViews(0);
        record.setLikes(0);
        record.setStatus(request.getStatus() != null ? request.getStatus() : 1);
        record.setCreatedAt(LocalDateTime.now());
        record.setUpdatedAt(LocalDateTime.now());
        recordMapper.insert(record);

        // 保存标签关联
        saveTagRelations(record.getId(), request.getTagIds());

        return record.getId();
    }

    @Override
    @Transactional
    public void updateArticle(ArticleRequest request) {
        com.mr.blog.entity.Record record = recordMapper.selectById(request.getId());
        if (record == null) {
            throw new RuntimeException("文章不存在");
        }
        record.setTitle(request.getTitle());
        record.setSummary(request.getSummary());
        record.setContent(request.getContent());
        record.setCover(request.getCover());
        record.setCategoryId(request.getCategoryId());
        if (request.getStatus() != null) {
            record.setStatus(request.getStatus());
        }
        record.setUpdatedAt(LocalDateTime.now());
        recordMapper.updateById(record);

        // 更新标签关联
        tagRelationMapper.deleteByRecordId(request.getId());
        saveTagRelations(request.getId(), request.getTagIds());
    }

    @Override
    @Transactional
    public void deleteArticle(Long id) {
        // 删除标签关联
        tagRelationMapper.deleteByRecordId(id);
        // 删除点赞记录
        LambdaQueryWrapper<RecordLike> likeWrapper = new LambdaQueryWrapper<>();
        likeWrapper.eq(RecordLike::getRecordId, id);
        likeMapper.delete(likeWrapper);
        // 删除文章
        recordMapper.deleteById(id);
    }

    @Override
    public List<RecordCategory> getCategoryTree() {
        // 获取一级分类
        List<RecordCategory> parents = categoryMapper.selectParentCategories();
        List<RecordCategory> result = new ArrayList<>();

        for (RecordCategory parent : parents) {
            result.add(parent);
            // 获取子分类
            List<RecordCategory> children = categoryMapper.selectByParentId(parent.getId());
            result.addAll(children);
        }
        return result;
    }

    @Override
    public List<RecordTag> getAllTags() {
        return tagMapper.selectList(null);
    }

    @Override
    public List<Long> getArticleTagIds(Long articleId) {
        List<RecordTag> tags = tagMapper.selectByRecordId(articleId);
        return tags.stream().map(RecordTag::getId).collect(Collectors.toList());
    }

    /**
     * 保存文章标签关联
     */
    private void saveTagRelations(Long recordId, List<Long> tagIds) {
        if (tagIds == null || tagIds.isEmpty()) {
            return;
        }
        for (Long tagId : tagIds) {
            RecordTagRelation relation = new RecordTagRelation();
            relation.setRecordId(recordId);
            relation.setTagId(tagId);
            tagRelationMapper.insert(relation);
            // 增加标签使用次数
            tagMapper.incrementUseCount(tagId);
        }
    }
}
