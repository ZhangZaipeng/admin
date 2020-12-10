package com.example.admin.service;

import com.example.admin.entity.SystemAdmin;
import com.example.admin.entity.SystemRole;
import java.util.List;

/**
 * @Description ：
 * @Tauthor ZhangZaipeng
 */
public interface SystemAdminService {

  List<String> findAdminPermission(Integer adminId);

  List<SystemMenuInfo> findAdminMenu(Integer adminId);

  int loginSuccess(SystemAdmin updateSystemAdmin);

  List<SystemRole> rolesList();

}
