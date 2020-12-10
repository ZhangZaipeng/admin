package com.example.admin.mapper;

import com.example.admin.config.mybatis.DefaultMapper;
import com.example.admin.entity.SystemPermission;
import java.util.List;

public interface SystemPermissionMapper extends DefaultMapper {
    int deleteByPrimaryKey(Long perId);

    int insert(SystemPermission record);

    int insertSelective(SystemPermission record);

    SystemPermission selectByPrimaryKey(Long perId);

    int updateByPrimaryKeySelective(SystemPermission record);

    int updateByPrimaryKey(SystemPermission record);

    List<String> selectAllPermission();

    List<String> selectPermissionByRoleId(int roleId);
}
