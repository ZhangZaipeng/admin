package com.example.admin.service;

import com.example.admin.entity.SystemAdmin;
import com.example.admin.entity.SystemRole;
import com.github.pagehelper.PageInfo;
import java.util.List;

/**
 * @Description ：
 */
public interface SystemAdminService {

  List<String> findAdminPermission(Integer adminId);

  List<SystemMenuInfo> findAdminMenu(Integer adminId);

  int loginSuccess(SystemAdmin updateSystemAdmin);

  PageInfo<SystemRole> rolesList(Integer currentPage, Integer limitSize, String roleName);

}
