package com.mr.blog.dto;

import lombok.Data;

@Data
public class CheckInVO {
    /**
     * 今日是否已签到
     */
    private Boolean checkedIn;

    /**
     * 连续签到天数
     */
    private Integer continuousDays;

    /**
     * 今日获得的经验值（如果已签到）
     */
    private Integer todayExp;

    /**
     * 下次签到可获得的经验值
     */
    private Integer nextExp;

    /**
     * 当前经验值
     */
    private Integer currentExp;

    /**
     * 当前等级
     */
    private Integer currentLevel;

    /**
     * 当前等级名称
     */
    private String currentLevelName;

    /**
     * 当前等级图标
     */
    private String currentLevelIcon;

    /**
     * 当前等级颜色
     */
    private String currentLevelColor;

    /**
     * 升级所需经验值
     */
    private Integer nextLevelExp;

    /**
     * 本月签到天数
     */
    private Integer monthCheckInDays;
}
