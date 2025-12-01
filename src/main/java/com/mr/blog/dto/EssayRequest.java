package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 发布随笔请求
 */
@Data
public class EssayRequest {
    private String content;
    private List<String> images;
    private List<String> videos;
}
