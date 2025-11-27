package com.mr.blog.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-path:E:/blog/blog-code/uploads/}")
    private String uploadPath;

    @Value("${cors.allowed-origins:http://localhost:8888}")
    private String allowedOrigins;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 将 /uploads/** 路径映射到本地文件目录
        // 确保路径以 / 结尾
        String path = uploadPath.endsWith("/") ? uploadPath : uploadPath + "/";
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + path);
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        // 支持多个域名，用逗号分隔
        String[] origins = allowedOrigins.split(",");

        // 允许所有 API 跨域访问
        registry.addMapping("/api/**")
                .allowedOrigins(origins)
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true);

        // 允许上传的图片资源跨域访问
        registry.addMapping("/uploads/**")
                .allowedOrigins(origins)
                .allowedMethods("GET");
    }
}
