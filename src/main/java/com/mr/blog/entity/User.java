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
     * 经验值
     */
    private Integer exp;

    /**
     * 等级ID，关联level表
     */
    private Integer levelId;

    /**
     * 角色：0-普通用户，1-管理员
     */
    private Integer role;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;
}
