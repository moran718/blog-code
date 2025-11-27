package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("user")
public class User {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String username;

    private String email;

    private String password;

    /**
     * 性别：0-未知，1-男，2-女
     */
    private Integer gender;

    private String avatar;

    private String bio;

    /**
     * 用户等级 1-5
     */
    private Integer level;

    /**
     * 用户称号
     */
    private String title;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
