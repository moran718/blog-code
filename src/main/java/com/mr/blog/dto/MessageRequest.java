package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 留言请求
 */
@Data
public class MessageRequest {
    private String content;
    private List<String> images;
}

