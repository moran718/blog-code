package com.mr.blog.service;

import java.util.Map;

public interface AiTarotService {
    /**
     * 抽取塔罗牌并解读
     * 
     * @param question 用户的问题
     * @return 包含卡牌信息和解读的 Map
     */
    Map<String, Object> drawCard(String question);
}
