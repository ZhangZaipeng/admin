package com.example.admin.config.interceptor;

import com.example.admin.service.SystemConfigService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * Created by zhangzp on 2018/9/17.
 */

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {

  Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

  @Autowired
  private SystemConfigService systemConfigService;

  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
      ModelAndView modelAndView) throws Exception {
    if (modelAndView == null) {
      super.postHandle(request, response, handler, modelAndView);
      return;
    }
    if (response.getStatus() == 200) {
      modelAndView.addObject("systemInfo", systemConfigService.getSetting());
    }
    super.postHandle(request, response, handler, modelAndView);
  }

}
