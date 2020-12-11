package com.example.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Description ：
 * @Tauthor ZhangZaipeng
 * @Tdata 2020/12/11   17:05
 */
@Controller
@RequestMapping("/order")
public class OrderController {

  /**
   * 订单列表
   */
  @RequestMapping("/list.htm")
  public ModelAndView orderList() {
    return new ModelAndView("order/list");
  }
}
