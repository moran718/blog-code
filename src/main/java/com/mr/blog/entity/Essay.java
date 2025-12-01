package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("essay")
public class Essay {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;

    private String content;

    /**
     * 图片URL，多张用逗号分隔
     */
    private String images;

    /**
     * 视频URL，多个用逗号分隔
     */
    private String videos;

    private Integer commentsCount;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
