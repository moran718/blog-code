package com.mr.blog.utils;

import java.util.*;

/**
 * 基于DFA（确定有限自动机）的敏感词过滤器
 */
public class SensitiveWordFilter {

    /**
     * DFA状态机根节点
     */
    private Map<Object, Object> sensitiveWordMap = new HashMap<>();

    /**
     * 敏感词与替换文本的映射
     */
    private Map<String, String> replacementMap = new HashMap<>();

    /**
     * 结束标志
     */
    private static final String END_FLAG = "isEnd";

    /**
     * 初始化敏感词库
     * 
     * @param wordReplacementMap 敏感词与替换文本的映射
     */
    public void init(Map<String, String> wordReplacementMap) {
        sensitiveWordMap.clear();
        replacementMap.clear();

        if (wordReplacementMap == null || wordReplacementMap.isEmpty()) {
            return;
        }

        replacementMap.putAll(wordReplacementMap);

        for (String word : wordReplacementMap.keySet()) {
            if (word == null || word.isEmpty()) {
                continue;
            }
            addWord(word);
        }
    }

    /**
     * 添加敏感词到DFA状态机
     */
    @SuppressWarnings("unchecked")
    private void addWord(String word) {
        Map<Object, Object> currentMap = sensitiveWordMap;

        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            Object obj = currentMap.get(c);

            if (obj == null) {
                Map<Object, Object> newMap = new HashMap<>();
                newMap.put(END_FLAG, false);
                currentMap.put(c, newMap);
                currentMap = newMap;
            } else {
                currentMap = (Map<Object, Object>) obj;
            }

            // 最后一个字符，标记为结束
            if (i == word.length() - 1) {
                currentMap.put(END_FLAG, true);
            }
        }
    }

    /**
     * 检查文本是否包含敏感词
     * 
     * @param text 待检查文本
     * @return 是否包含敏感词
     */
    public boolean contains(String text) {
        if (text == null || text.isEmpty() || sensitiveWordMap.isEmpty()) {
            return false;
        }

        for (int i = 0; i < text.length(); i++) {
            int length = checkSensitiveWord(text, i);
            if (length > 0) {
                return true;
            }
        }
        return false;
    }

    /**
     * 查找文本中所有敏感词
     * 
     * @param text 待检查文本
     * @return 敏感词列表
     */
    public List<String> findAll(String text) {
        List<String> result = new ArrayList<>();

        if (text == null || text.isEmpty() || sensitiveWordMap.isEmpty()) {
            return result;
        }

        for (int i = 0; i < text.length(); i++) {
            int length = checkSensitiveWord(text, i);
            if (length > 0) {
                result.add(text.substring(i, i + length));
                i += length - 1; // 跳过已匹配的字符
            }
        }
        return result;
    }

    /**
     * 过滤敏感词，替换为指定文本
     * 
     * @param text               待过滤文本
     * @param defaultReplacement 默认替换文本
     * @return 过滤后的文本
     */
    public String filter(String text, String defaultReplacement) {
        if (text == null || text.isEmpty() || sensitiveWordMap.isEmpty()) {
            return text;
        }

        StringBuilder result = new StringBuilder();
        int i = 0;

        while (i < text.length()) {
            int length = checkSensitiveWord(text, i);
            if (length > 0) {
                String word = text.substring(i, i + length);
                // 使用词语对应的替换文本，如果没有则使用默认值
                String replacement = replacementMap.getOrDefault(word, defaultReplacement);
                result.append(replacement);
                i += length;
            } else {
                result.append(text.charAt(i));
                i++;
            }
        }
        return result.toString();
    }

    /**
     * 检查从指定位置开始的敏感词长度
     * 
     * @param text       文本
     * @param startIndex 开始位置
     * @return 敏感词长度，0表示没有匹配
     */
    @SuppressWarnings("unchecked")
    private int checkSensitiveWord(String text, int startIndex) {
        Map<Object, Object> currentMap = sensitiveWordMap;
        int matchLength = 0;
        int lastMatchLength = 0;

        for (int i = startIndex; i < text.length(); i++) {
            char c = text.charAt(i);
            Object obj = currentMap.get(c);

            if (obj == null) {
                break;
            }

            currentMap = (Map<Object, Object>) obj;
            matchLength++;

            // 检查是否是一个完整的敏感词
            Object isEnd = currentMap.get(END_FLAG);
            if (isEnd != null && (Boolean) isEnd) {
                lastMatchLength = matchLength;
            }
        }

        return lastMatchLength;
    }

    /**
     * 获取敏感词数量
     */
    public int getWordCount() {
        return replacementMap.size();
    }

    /**
     * 清空敏感词库
     */
    public void clear() {
        sensitiveWordMap.clear();
        replacementMap.clear();
    }
}
