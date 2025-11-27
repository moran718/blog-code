package com.mr.blog.utils;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.mr.blog.dto.PageVO;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 分页工具类
 */
public class PageUtils {

    /**
     * 默认页码
     */
    public static final int DEFAULT_PAGE = 1;

    /**
     * 默认每页条数
     */
    public static final int DEFAULT_PAGE_SIZE = 5;

    /**
     * 最大每页条数
     */
    public static final int MAX_PAGE_SIZE = 20;

    /**
     * 校验并修正分页参数
     *
     * @param page     页码
     * @param pageSize 每页条数
     * @return 修正后的分页参数 [page, pageSize]
     */
    public static int[] validateParams(Integer page, Integer pageSize) {
        int validPage = (page == null || page < 1) ? DEFAULT_PAGE : page;
        int validPageSize = (pageSize == null || pageSize < 1) ? DEFAULT_PAGE_SIZE : pageSize;
        if (validPageSize > MAX_PAGE_SIZE) {
            validPageSize = MAX_PAGE_SIZE;
        }
        return new int[]{validPage, validPageSize};
    }

    /**
     * 创建 MyBatis-Plus 分页对象
     *
     * @param page     页码
     * @param pageSize 每页条数
     * @return Page 对象
     */
    public static <T> Page<T> createPage(int page, int pageSize) {
        return new Page<>(page, pageSize);
    }

    /**
     * 将 MyBatis-Plus 分页结果转换为 PageVO
     *
     * @param page MyBatis-Plus 分页结果
     * @return PageVO
     */
    public static <T> PageVO<T> toPageVO(Page<T> page) {
        return PageVO.of(
                page.getRecords(),
                page.getTotal(),
                (int) page.getCurrent(),
                (int) page.getSize()
        );
    }

    /**
     * 将 MyBatis-Plus 分页结果转换为 PageVO，支持数据转换
     *
     * @param page      MyBatis-Plus 分页结果
     * @param converter 数据转换函数
     * @return PageVO
     */
    public static <T, R> PageVO<R> toPageVO(Page<T> page, Function<T, R> converter) {
        List<R> list = page.getRecords().stream()
                .map(converter)
                .collect(Collectors.toList());
        return PageVO.of(
                list,
                page.getTotal(),
                (int) page.getCurrent(),
                (int) page.getSize()
        );
    }

    /**
     * 将 MyBatis-Plus 分页结果转换为 PageVO，支持批量数据转换
     *
     * @param page          MyBatis-Plus 分页结果
     * @param convertedList 已转换的数据列表
     * @return PageVO
     */
    public static <T, R> PageVO<R> toPageVO(Page<T> page, List<R> convertedList) {
        return PageVO.of(
                convertedList,
                page.getTotal(),
                (int) page.getCurrent(),
                (int) page.getSize()
        );
    }
}

