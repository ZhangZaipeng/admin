package com.example.admin.controller;

import com.example.admin.common.constant.Const;
import com.example.admin.entity.SystemAdmin;
import com.example.admin.service.SystemAdminService;
import com.example.admin.service.SystemMenuInfo;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {

  @Autowired
  private SystemAdminService systemAdminService;

  /**
   * 跳转首页
   *
   * @return
   */
  @RequestMapping(value = {"", "/", "/index.htm"})
  public ModelAndView index() {
    //  渲染 index.ftl 页面数据

    Subject subject = SecurityUtils.getSubject();

    SystemAdmin admin = (SystemAdmin) subject.getPrincipal();

    List<SystemMenuInfo> systemMenuInfos = systemAdminService.findAdminMenu(admin.getAdminId());

    Map<String, Object> model = new HashMap<>();
    model.put("systemMenuInfos", systemMenuInfos);

    model.put("admin", admin);

    return new ModelAndView("admin/index", model);
  }

  /**
   * console
   *
   * @return
   */
  @RequestMapping(value = {"console.htm"})
  public ModelAndView welcome() {
    Map<String,Object> model = new HashMap<>();
    long userCount = 1;
    model.put("userCount", userCount);

    long bookSourceCount = 2;
    model.put("bookSourceCount", bookSourceCount);

    long donateCount = 3;
    model.put("donateCount", donateCount);

    long updateLogCount = 4;
    model.put("updateLogCount", updateLogCount);

    model.put("notifications",new ArrayList<>());

    return new ModelAndView("admin/console", model);
  }


  @RequestMapping("/clearCache")
  @ResponseBody
  @RequiresPermissions(value = {"ADMIN_VIEW", Const.role.ROLE_SUPER}, logical = Logical.OR)
  public Map<String, Object> clearCache() {
    Map<String, Object> map = new HashMap<>();
    try {
      // redisService.removePattern("*");
      map.put("code", 1);
      map.put("msg", "清除成功");
    } catch (Exception e) {
      map.put("code", 2);
      if (StringUtils.isEmpty(e.getMessage())) {
        map.put("msg", "未知异常");
      } else {
        map.put("msg", e.getMessage());
      }
    }
    return map;
  }
}
