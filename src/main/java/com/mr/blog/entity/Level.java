package com.mr.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("level")
public class Level {

    @TableId(type = IdType.INPUT)
    private Integer id;

    /**
     * 等级名称
     */
    private String name;

    /**
     * 该等级最低经验值
     */
    private Integer minExp;

    /**
     * 等级图标
     */
    private String icon;

    /**
     * 等级颜色
     */
    private String color;

    /**
     * 等级描述
     */
    private String description;
}