package com.example.admin.mapper;

import com.example.admin.config.mybatis.DefaultMapper;
import com.example.admin.entity.SystemRole;
import java.util.List;

public interface SystemRoleMapper extends DefaultMapper {

  int deleteByPrimaryKey(Integer roleId);

  int insert(SystemRole record);

  int insertSelective(SystemRole record);

  SystemRole selectByPrimaryKey(Integer roleId);

  int updateByPrimaryKeySelective(SystemRole record);

  int updateByPrimaryKey(SystemRole record);

  List<SystemRole> rolesList();
}
