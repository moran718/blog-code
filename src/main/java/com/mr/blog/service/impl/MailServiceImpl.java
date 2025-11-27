package com.mr.blog.service.impl;

import com.mr.blog.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Override
    public void sendVerificationCode(String to, String code) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(to);
        message.setSubject("【个人博客】邮箱验证码");
        message.setText("您的验证码是：" + code + "\n\n验证码有效期为5分钟，请尽快使用。\n\n如非本人操作，请忽略此邮件。");
        mailSender.send(message);
    }
}

