package com.example.admin.mapper;

import com.example.admin.config.mybatis.DefaultMapper;
import com.example.admin.entity.SystemConfig;

public interface SystemConfigMapper extends DefaultMapper {
    int deleteByPrimaryKey(String key);

    int insert(SystemConfig record);

    int insertSelective(SystemConfig record);

    SystemConfig selectByPrimaryKey(String key);

    int updateByPrimaryKeySelective(SystemConfig record);

    int updateByPrimaryKey(SystemConfig record);
}
