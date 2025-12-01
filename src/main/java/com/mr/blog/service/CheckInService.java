package com.mr.blog.service;

import com.mr.blog.dto.CheckInVO;

public interface CheckInService {

    /**
     * 获取签到状态
     */
    CheckInVO getCheckInStatus(Long userId);

    /**
     * 签到
     */
    CheckInVO checkIn(Long userId);
}

