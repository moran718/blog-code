package com.mr.blog.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.mr.blog.dto.CheckInVO;
import com.mr.blog.entity.CheckIn;
import com.mr.blog.entity.Level;
import com.mr.blog.entity.User;
import com.mr.blog.mapper.CheckInMapper;
import com.mr.blog.mapper.LevelMapper;
import com.mr.blog.mapper.UserMapper;
import com.mr.blog.service.CheckInService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.annotation.PostConstruct;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.List;

@Service
public class CheckInServiceImpl implements CheckInService {

    @Autowired
    private CheckInMapper checkInMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LevelMapper levelMapper;

    // 缓存等级配置
    private List<Level> levelList;

    @PostConstruct
    public void init() {
        // 启动时加载等级配置并按minExp升序排列
        levelList = levelMapper.selectList(
                new LambdaQueryWrapper<Level>().orderByAsc(Level::getMinExp));
    }

    @Override
    public CheckInVO getCheckInStatus(Long userId) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        LocalDate today = LocalDate.now();
        CheckIn todayCheckIn = getTodayCheckIn(userId, today);

        CheckInVO vo = new CheckInVO();
        vo.setCheckedIn(todayCheckIn != null);
        vo.setCurrentExp(user.getExp() != null ? user.getExp() : 0);
        int currentLevel = user.getLevelId() != null ? user.getLevelId() : 1;
        vo.setCurrentLevel(currentLevel);

        // 填充等级信息
        fillLevelInfo(vo, currentLevel);

        // 计算连续签到天数
        int continuousDays = calculateContinuousDays(userId, today, todayCheckIn != null);
        vo.setContinuousDays(continuousDays);

        if (todayCheckIn != null) {
            vo.setTodayExp(todayCheckIn.getExpGained());
            // 明天如果继续签到可获得的经验
            vo.setNextExp(calculateNextExp(continuousDays + 1));
        } else {
            vo.setTodayExp(0);
            // 今天签到可获得的经验
            vo.setNextExp(calculateNextExp(continuousDays + 1));
        }

        // 计算升级所需经验
        vo.setNextLevelExp(getNextLevelExp(vo.getCurrentLevel()));

        // 计算本月签到天数
        vo.setMonthCheckInDays(getMonthCheckInDays(userId, today));

        return vo;
    }

    @Override
    @Transactional
    public CheckInVO checkIn(Long userId) {
        User user = userMapper.selectById(userId);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        LocalDate today = LocalDate.now();

        // 检查今天是否已签到
        CheckIn todayCheckIn = getTodayCheckIn(userId, today);
        if (todayCheckIn != null) {
            throw new RuntimeException("今天已经签到过了");
        }

        // 计算连续签到天数
        int continuousDays = calculateContinuousDays(userId, today, false) + 1;

        // 计算获得的经验值
        int expGained = calculateNextExp(continuousDays);

        // 创建签到记录
        CheckIn checkIn = new CheckIn();
        checkIn.setUserId(userId);
        checkIn.setCheckDate(today);
        checkIn.setExpGained(expGained);
        checkIn.setContinuousDays(continuousDays);
        checkIn.setCreatedAt(LocalDateTime.now());
        checkInMapper.insert(checkIn);

        // 更新用户经验值和等级
        int currentExp = user.getExp() != null ? user.getExp() : 0;
        int newExp = currentExp + expGained;
        int newLevel = calculateLevel(newExp);

        user.setExp(newExp);
        user.setLevelId(newLevel);
        user.setUpdateTime(LocalDateTime.now());
        userMapper.updateById(user);

        // 返回签到结果
        CheckInVO vo = new CheckInVO();
        vo.setCheckedIn(true);
        vo.setContinuousDays(continuousDays);
        vo.setTodayExp(expGained);
        vo.setNextExp(calculateNextExp(continuousDays + 1));
        vo.setCurrentExp(newExp);
        vo.setCurrentLevel(newLevel);
        fillLevelInfo(vo, newLevel);
        vo.setNextLevelExp(getNextLevelExp(newLevel));
        vo.setMonthCheckInDays(getMonthCheckInDays(userId, today));

        return vo;
    }

    /**
     * 填充等级信息
     */
    private void fillLevelInfo(CheckInVO vo, int levelId) {
        if (levelList != null) {
            for (Level level : levelList) {
                if (level.getId().equals(levelId)) {
                    vo.setCurrentLevelName(level.getName());
                    vo.setCurrentLevelIcon(level.getIcon());
                    vo.setCurrentLevelColor(level.getColor());
                    break;
                }
            }
        }
    }

    /**
     * 获取今天的签到记录
     */
    private CheckIn getTodayCheckIn(Long userId, LocalDate today) {
        return checkInMapper.selectOne(
                new LambdaQueryWrapper<CheckIn>()
                        .eq(CheckIn::getUserId, userId)
                        .eq(CheckIn::getCheckDate, today));
    }

    /**
     * 计算连续签到天数
     */
    private int calculateContinuousDays(Long userId, LocalDate today, boolean includingToday) {
        LocalDate checkDate = includingToday ? today : today.minusDays(1);
        int days = 0;

        while (true) {
            CheckIn checkIn = checkInMapper.selectOne(
                    new LambdaQueryWrapper<CheckIn>()
                            .eq(CheckIn::getUserId, userId)
                            .eq(CheckIn::getCheckDate, checkDate));
            if (checkIn == null) {
                break;
            }
            days++;
            checkDate = checkDate.minusDays(1);
        }

        return days;
    }

    /**
     * 计算下次签到可获得的经验值
     * 第一天10经验，连续签到每天+5，最高50经验
     */
    private int calculateNextExp(int continuousDays) {
        int exp = 10 + (continuousDays - 1) * 5;
        return Math.min(exp, 50);
    }

    /**
     * 根据经验值计算等级（从等级表读取配置）
     */
    private int calculateLevel(int exp) {
        if (levelList == null || levelList.isEmpty()) {
            return 1;
        }
        // 从高到低遍历，找到第一个满足条件的等级
        for (int i = levelList.size() - 1; i >= 0; i--) {
            if (exp >= levelList.get(i).getMinExp()) {
                return levelList.get(i).getId();
            }
        }
        return 1;
    }

    /**
     * 获取升级所需经验值（从等级表读取配置）
     */
    private int getNextLevelExp(int currentLevel) {
        if (levelList == null || levelList.isEmpty()) {
            return 0;
        }
        // 找到下一级的minExp
        for (Level level : levelList) {
            if (level.getId() > currentLevel) {
                return level.getMinExp();
            }
        }
        return 0; // 已满级
    }

    /**
     * 获取本月签到天数
     */
    private int getMonthCheckInDays(Long userId, LocalDate today) {
        YearMonth yearMonth = YearMonth.from(today);
        LocalDate firstDay = yearMonth.atDay(1);
        LocalDate lastDay = yearMonth.atEndOfMonth();

        Long count = checkInMapper.selectCount(
                new LambdaQueryWrapper<CheckIn>()
                        .eq(CheckIn::getUserId, userId)
                        .ge(CheckIn::getCheckDate, firstDay)
                        .le(CheckIn::getCheckDate, lastDay));
        return count != null ? count.intValue() : 0;
    }
}
