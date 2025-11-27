package com.mr.blog.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.mr.blog.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}

