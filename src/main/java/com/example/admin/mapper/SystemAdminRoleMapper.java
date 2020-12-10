package com.example.admin.mapper;

import com.example.admin.config.mybatis.DefaultMapper;
import com.example.admin.entity.SystemAdminRole;

public interface SystemAdminRoleMapper extends DefaultMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SystemAdminRole record);

    int insertSelective(SystemAdminRole record);

    SystemAdminRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SystemAdminRole record);

    int updateByPrimaryKey(SystemAdminRole record);
}
