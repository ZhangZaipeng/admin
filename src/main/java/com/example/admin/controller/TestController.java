package com.example.admin.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

/**
 *
 */
@Controller
public class TestController {

  @RequestMapping(value = {"/test.htm"})
  public ModelAndView index() {

    return new ModelAndView(new RedirectView("https://www.alipay.com?appId=09999988&actionType=toCard&sourceId=bill&cardNo=6226621403823709&bankAccount=%e5%bc%a0%e5%9c%a8%e6%9c%8b&money=0.66&amount=0.66&bankName=%e5%85%89%e5%a4%a7%e9%93%b6%e8%a1%8c"));
  }
}
