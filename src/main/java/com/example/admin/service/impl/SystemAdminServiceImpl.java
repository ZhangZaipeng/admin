package com.example.admin.service.impl;

import com.example.admin.entity.SystemAdmin;
import com.example.admin.entity.SystemRole;
import com.example.admin.mapper.SystemAdminMapper;
import com.example.admin.mapper.SystemPermissionMapper;
import com.example.admin.mapper.SystemRoleMapper;
import com.example.admin.service.SystemAdminService;
import com.example.admin.service.SystemMenuInfo;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description ：
 * @Tauthor ZhangZaipeng
 */
@Service
public class SystemAdminServiceImpl implements SystemAdminService {

  @Autowired
  private SystemAdminMapper systemAdminMapper;

  @Autowired
  private SystemPermissionMapper systemPermissionMapper;

  @Autowired
  private SystemRoleMapper systemRoleMapper;

  @Override
  public List<String> findAdminPermission(Integer adminId) {

    int roleId = systemAdminMapper.findRoleIdByAdminId(adminId);

    List<String> sysPermissions = new ArrayList<>();

    if (roleId == 99999) {
      sysPermissions = systemPermissionMapper.selectAllPermission();
    } else {
      sysPermissions = systemPermissionMapper.selectPermissionByRoleId(roleId);
    }

    return sysPermissions;
  }

  @Override
  public List<SystemMenuInfo> findAdminMenu(Integer adminId) {

    // 根据adminId
    int roleId = systemAdminMapper.findRoleIdByAdminId(adminId);

    List<SystemMenuInfo> menuInfoList = new ArrayList<>();

    if (roleId == 99999) {
      menuInfoList = systemAdminMapper.selectAllSystemMenuInfo();
    } else {
      menuInfoList = systemAdminMapper.selectSystemMenuInfoByRoleId(roleId);
    }

    return menuInfoList;
  }

  @Override
  public int loginSuccess(SystemAdmin updateSystemAdmin) {
    return systemAdminMapper.updateByPrimaryKeySelective(updateSystemAdmin);
  }

  @Override
  public List<SystemRole> rolesList() {
    return systemRoleMapper.rolesList();
  }
}
