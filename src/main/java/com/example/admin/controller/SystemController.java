package com.example.admin.controller;

import com.example.admin.common.response.ResponseModel;
import com.example.admin.entity.SystemRole;
import com.example.admin.service.SystemAdminService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Description ：
 */
@Controller
@RequestMapping("/system")
public class SystemController {

  @Autowired
  private SystemAdminService systemAdminService;

  /**
   * 角色列表
   */
  @RequestMapping("/roles.htm")
  public ModelAndView rolesList() {
    return new ModelAndView("role/roles");
  }

  @RequestMapping("/roles.json")
  @ResponseBody
  public ResponseModel rolesListData(Integer currentPage, Integer limitSize, String roleName) {

    PageInfo<SystemRole> systemRoles = systemAdminService
        .rolesList(currentPage, limitSize, roleName);

    return ResponseModel.ok(systemRoles);
  }

  /**
   * 权限列表
   */
  @RequestMapping("/roleform.htm")
  public ModelAndView roleform() {

    return new ModelAndView("role/roleform");
  }

  @RequestMapping("/auths.htm")
  public ModelAndView authList() {
    return new ModelAndView("role/auths");
  }

  @RequestMapping("/adminList.htm")
  public ModelAndView adminList() {
    return new ModelAndView("admin/list");
  }

  @RequestMapping("/adminInfo.htm")
  public ModelAndView adminInfo() {
    return new ModelAndView("admin/info");
  }

  @RequestMapping("/changePwd.htm")
  public ModelAndView adminPwd() {
    return new ModelAndView("admin/pwd");
  }
}
