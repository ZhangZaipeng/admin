package com.example.admin.controller;

import com.example.admin.entity.SystemRole;
import com.example.admin.service.SystemAdminService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Description ：
 * @Tauthor ZhangZaipeng
 * @Tdata 2020/12/10   15:23
 */
@Controller
@RequestMapping("/system")
public class SystemController {

  @Autowired
  private SystemAdminService systemAdminService;

  /**
   * 角色列表
   * @return
   */
  @RequestMapping("/roles.htm")
  public ModelAndView rolesList() {

    Map<String,Object> datas = new HashMap<>();

    List<SystemRole> systemRoles = systemAdminService.rolesList();

    datas.put("roleList", systemRoles);

    return new ModelAndView("role/roles", datas);
  }

  /**
   * 权限列表
   * @return
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
