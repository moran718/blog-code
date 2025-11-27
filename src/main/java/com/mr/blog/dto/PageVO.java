package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 分页响应VO
 */
@Data
public class PageVO<T> {
    /**
     * 当前页码
     */
    private Integer page;
    
    /**
     * 每页条数
     */
    private Integer pageSize;
    
    /**
     * 总条数
     */
    private Long total;
    
    /**
     * 总页数
     */
    private Integer totalPages;
    
    /**
     * 数据列表
     */
    private List<T> list;
    
    /**
     * 是否有下一页
     */
    private Boolean hasNext;
    
    /**
     * 是否有上一页
     */
    private Boolean hasPrev;
    
    public static <T> PageVO<T> of(List<T> list, long total, int page, int pageSize) {
        PageVO<T> pageVO = new PageVO<>();
        pageVO.setList(list);
        pageVO.setTotal(total);
        pageVO.setPage(page);
        pageVO.setPageSize(pageSize);
        
        int totalPages = (int) Math.ceil((double) total / pageSize);
        pageVO.setTotalPages(totalPages);
        pageVO.setHasNext(page < totalPages);
        pageVO.setHasPrev(page > 1);
        
        return pageVO;
    }
}

