package com.example.admin.mapper;

import com.example.admin.config.mybatis.DefaultMapper;
import com.example.admin.entity.SystemRolePermission;

public interface SystemRolePermissionMapper extends DefaultMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SystemRolePermission record);

    int insertSelective(SystemRolePermission record);

    SystemRolePermission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SystemRolePermission record);

    int updateByPrimaryKey(SystemRolePermission record);
}
