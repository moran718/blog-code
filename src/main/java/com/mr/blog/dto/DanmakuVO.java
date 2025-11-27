package com.mr.blog.dto;

import lombok.Data;

/**
 * 弹幕返回VO
 */
@Data
public class DanmakuVO {
    private Long id;
    private String content;
    private String avatar;
    private Integer likes;
    private Boolean liked;
}

