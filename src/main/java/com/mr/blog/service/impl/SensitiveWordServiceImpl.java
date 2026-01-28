package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.PageVO;
import com.mr.blog.entity.SensitiveWord;
import com.mr.blog.entity.SystemConfig;
import com.mr.blog.mapper.SensitiveWordMapper;
import com.mr.blog.mapper.SystemConfigMapper;
import com.mr.blog.service.SensitiveWordService;
import com.mr.blog.utils.PageUtils;
import com.mr.blog.utils.SensitiveWordFilter;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SensitiveWordServiceImpl implements SensitiveWordService {

    @Autowired
    private SensitiveWordMapper sensitiveWordMapper;

    @Autowired
    private SystemConfigMapper systemConfigMapper;

    private final SensitiveWordFilter filter = new SensitiveWordFilter();

    private static final String STRATEGY_KEY = "sensitive_word_strategy";
    private static final String STRATEGY_REPLACE = "replace";
    private static final String STRATEGY_BLOCK = "block";

    @PostConstruct
    public void init() {
        reloadFilter();
    }

    @Override
    public PageVO<SensitiveWord> getPageList(int page, int size, String keyword) {
        Page<SensitiveWord> pageParam = PageUtils.createPage(page, size);
        LambdaQueryWrapper<SensitiveWord> wrapper = new LambdaQueryWrapper<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.like(SensitiveWord::getWord, keyword.trim());
        }
        wrapper.orderByDesc(SensitiveWord::getCreatedAt);

        Page<SensitiveWord> result = sensitiveWordMapper.selectPage(pageParam, wrapper);
        return PageUtils.toPageVO(result, result.getRecords());
    }

    @Override
    public List<SensitiveWord> getAllEnabled() {
        LambdaQueryWrapper<SensitiveWord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SensitiveWord::getEnabled, 1);
        return sensitiveWordMapper.selectList(wrapper);
    }

    @Override
    public SensitiveWord getById(Long id) {
        return sensitiveWordMapper.selectById(id);
    }

    @Override
    @Transactional
    public void add(SensitiveWord sensitiveWord) {
        // 检查是否已存在
        LambdaQueryWrapper<SensitiveWord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SensitiveWord::getWord, sensitiveWord.getWord());
        if (sensitiveWordMapper.selectCount(wrapper) > 0) {
            throw new RuntimeException("敏感词已存在");
        }

        sensitiveWord.setEnabled(sensitiveWord.getEnabled() == null ? 1 : sensitiveWord.getEnabled());
        sensitiveWord.setReplacement(sensitiveWord.getReplacement() == null ? "***" : sensitiveWord.getReplacement());
        sensitiveWord.setCreatedAt(LocalDateTime.now());
        sensitiveWord.setUpdatedAt(LocalDateTime.now());
        sensitiveWordMapper.insert(sensitiveWord);
        reloadFilter();
    }

    @Override
    @Transactional
    public void update(SensitiveWord sensitiveWord) {
        SensitiveWord existing = sensitiveWordMapper.selectById(sensitiveWord.getId());
        if (existing == null) {
            throw new RuntimeException("敏感词不存在");
        }

        // 检查是否与其他敏感词重复
        LambdaQueryWrapper<SensitiveWord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SensitiveWord::getWord, sensitiveWord.getWord())
                .ne(SensitiveWord::getId, sensitiveWord.getId());
        if (sensitiveWordMapper.selectCount(wrapper) > 0) {
            throw new RuntimeException("敏感词已存在");
        }

        existing.setWord(sensitiveWord.getWord());
        existing.setReplacement(sensitiveWord.getReplacement());
        existing.setEnabled(sensitiveWord.getEnabled());
        existing.setUpdatedAt(LocalDateTime.now());
        sensitiveWordMapper.updateById(existing);
        reloadFilter();
    }

    @Override
    @Transactional
    public void delete(Long id) {
        sensitiveWordMapper.deleteById(id);
        reloadFilter();
    }

    @Override
    @Transactional
    public void batchAdd(List<String> words) {
        if (words == null || words.isEmpty()) {
            return;
        }

        int addCount = 0;
        for (String word : words) {
            if (word == null || word.trim().isEmpty()) {
                continue;
            }
            String trimmedWord = word.trim();

            // 检查是否已存在
            LambdaQueryWrapper<SensitiveWord> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(SensitiveWord::getWord, trimmedWord);
            if (sensitiveWordMapper.selectCount(wrapper) > 0) {
                continue;
            }

            SensitiveWord sensitiveWord = new SensitiveWord();
            sensitiveWord.setWord(trimmedWord);
            sensitiveWord.setReplacement("***");
            sensitiveWord.setEnabled(1);
            sensitiveWord.setCreatedAt(LocalDateTime.now());
            sensitiveWord.setUpdatedAt(LocalDateTime.now());
            sensitiveWordMapper.insert(sensitiveWord);
            addCount++;
        }

        if (addCount > 0) {
            reloadFilter();
        }
    }

    @Override
    @Transactional
    public void toggleEnabled(Long id) {
        SensitiveWord sensitiveWord = sensitiveWordMapper.selectById(id);
        if (sensitiveWord == null) {
            throw new RuntimeException("敏感词不存在");
        }
        sensitiveWord.setEnabled(sensitiveWord.getEnabled() == 1 ? 0 : 1);
        sensitiveWord.setUpdatedAt(LocalDateTime.now());
        sensitiveWordMapper.updateById(sensitiveWord);
        reloadFilter();
    }

    @Override
    public String filterContent(String content) {
        if (content == null || content.isEmpty()) {
            return content;
        }

        String strategy = getStrategy();

        if (STRATEGY_BLOCK.equals(strategy)) {
            if (filter.contains(content)) {
                List<String> words = filter.findAll(content);
                throw new RuntimeException("内容包含敏感词：" + String.join("、", words));
            }
            return content;
        } else {
            // 替换模式
            return filter.filter(content, "***");
        }
    }

    @Override
    public boolean containsSensitiveWord(String content) {
        if (content == null || content.isEmpty()) {
            return false;
        }
        return filter.contains(content);
    }

    @Override
    public List<String> findSensitiveWords(String content) {
        return filter.findAll(content);
    }

    @Override
    public String getStrategy() {
        LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SystemConfig::getConfigKey, STRATEGY_KEY);
        SystemConfig config = systemConfigMapper.selectOne(wrapper);

        if (config == null) {
            return STRATEGY_REPLACE;
        }
        return config.getConfigValue();
    }

    @Override
    @Transactional
    public void setStrategy(String strategy) {
        if (!STRATEGY_REPLACE.equals(strategy) && !STRATEGY_BLOCK.equals(strategy)) {
            throw new RuntimeException("无效的策略值");
        }

        LambdaQueryWrapper<SystemConfig> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SystemConfig::getConfigKey, STRATEGY_KEY);
        SystemConfig config = systemConfigMapper.selectOne(wrapper);

        if (config == null) {
            config = new SystemConfig();
            config.setConfigKey(STRATEGY_KEY);
            config.setConfigValue(strategy);
            config.setDescription("敏感词策略：replace-替换 block-禁止");
            config.setUpdatedAt(LocalDateTime.now());
            systemConfigMapper.insert(config);
        } else {
            config.setConfigValue(strategy);
            config.setUpdatedAt(LocalDateTime.now());
            systemConfigMapper.updateById(config);
        }
    }

    @Override
    public void reloadFilter() {
        List<SensitiveWord> enabledWords = getAllEnabled();
        Map<String, String> wordReplacementMap = new HashMap<>();

        for (SensitiveWord word : enabledWords) {
            wordReplacementMap.put(word.getWord(), word.getReplacement());
        }

        filter.init(wordReplacementMap);
    }
}
