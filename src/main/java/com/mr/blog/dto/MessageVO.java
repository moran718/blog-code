package com.mr.blog.dto;

import lombok.Data;

import java.util.List;

/**
 * 留言返回VO
 */
@Data
public class MessageVO {
    private Long id;
    private String content;
    private List<String> images;
    private String date;
    private UserVO user;
    private List<ReplyVO> replies;

    @Data
    public static class UserVO {
        private Long id;
        private String name;
        private String avatar;
        private Integer level;
        private String levelName; // 等级名称
        private String levelIcon; // 等级图标
        private String levelColor; // 等级颜色
        private String title;
    }

    @Data
    public static class ReplyVO {
        private Long id;
        private UserVO user;
        private String content;
        private String date;
        private String replyTo;
    }
}
