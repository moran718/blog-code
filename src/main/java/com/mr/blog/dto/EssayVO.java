package com.mr.blog.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 随笔返回VO
 */
@Data
public class EssayVO {
    private Long id;
    private String content;
    private List<String> images;
    private List<String> videos;
    private Integer comments;
    private String date;
    private UserVO user;
    private List<CommentVO> commentList;

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
    public static class CommentVO {
        private Long id;
        private UserVO user;
        private String content;
        private List<String> images;
        private String date;
        private List<ReplyVO> replies;
    }

    @Data
    public static class ReplyVO {
        private Long id;
        private UserVO user;
        private String content;
        private List<String> images;
        private String date;
        private String replyTo; // 被回复用户名，仅三级回复有值
    }
}
