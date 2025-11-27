package com.mr.blog.dto;

import lombok.Data;

@Data
public class LoginRequest {
    private String email;
    private String password;
    private String code;
    /**
     * 登录类型：password-密码登录，code-验证码登录
     */
    private String loginType;
}

