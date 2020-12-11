package com.example.admin.controller;

import com.example.admin.common.constant.Const;
import com.example.admin.common.response.ResponseModel;
import com.example.admin.common.tools.CaptchaUtils;
import com.example.admin.common.tools.IpUtil;
import com.example.admin.entity.SystemAdmin;
import com.example.admin.service.SystemAdminService;
import java.io.IOException;
import java.util.Date;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Description ：
 */
@Controller
@RequestMapping("/login")
public class LoginController {

  @Autowired
  private SystemAdminService systemAdminService;

  /**
   * 生成验证码
   */
  @ResponseBody
  @RequestMapping(value = "/verificationCode.json")
  public void setVerificationCode(HttpSession session, HttpServletResponse response)
      throws IOException {
    response.setContentType("image/png");
    String random = CaptchaUtils.random();
    //输出图片
    CaptchaUtils.outputImage(random, response.getOutputStream());
    //存入结果
    session.setAttribute(Const.session.VERIFICATION_CODE, CaptchaUtils.num);
  }

  @RequestMapping("/tologin.htm")
  public ModelAndView login() {
    Subject subject = SecurityUtils.getSubject();
    //如果已经认证通过，直接跳转到首页
    if (subject.isAuthenticated()) {
      return new ModelAndView("redirect:/index.htm");
    }
    return new ModelAndView("login");
  }

  @RequestMapping(method = RequestMethod.POST, value = "/doLogin.json")
  @ResponseBody
  public ResponseModel doLogin(String username, String password, String captcha, boolean rememberMe,
      HttpSession session, HttpServletRequest request) {
    if (captcha == null || !Objects
        .equals(captcha, session.getAttribute(Const.session.VERIFICATION_CODE).toString())) {
      return ResponseModel.error("验证码错误");
    } else if (StringUtils.isEmpty(username)) {
      return ResponseModel.error("账号不能为空");
    } else if (StringUtils.isEmpty(password)) {
      return ResponseModel.error("密码不能为空");
    } else {
      Subject subject = SecurityUtils.getSubject();
      UsernamePasswordToken token = new UsernamePasswordToken(username, password, rememberMe);
      try {
        subject.login(token);
        if (subject.isAuthenticated()) {

          SystemAdmin admin = (SystemAdmin) subject.getPrincipal();

          session.setAttribute(Const.session.LOGIN_ADMIN, admin);

          SystemAdmin updateSystemAdmin = new SystemAdmin();
          updateSystemAdmin.setAdminId(admin.getAdminId());
          updateSystemAdmin.setLastLoginTime(new Date());

          String ip = IpUtil.getIpAddr(request);
          updateSystemAdmin.setLoginIp(ip);

          systemAdminService.loginSuccess(updateSystemAdmin);

          return ResponseModel.ok("登录成功");
        }
        return ResponseModel.error("登录失败");
      } catch (UnknownAccountException uae) {
        return ResponseModel.error("未知账户");
      } catch (IncorrectCredentialsException ice) {
        return ResponseModel.error("密码不正确");
      } catch (LockedAccountException lae) {
        return ResponseModel.error("账户已锁定");
      } catch (ExcessiveAttemptsException eae) {
        return ResponseModel.error("用户名或密码错误次数过多");
      } catch (AuthenticationException ae) {
        return ResponseModel.error("用户名或密码不正确");
      } catch (UnauthorizedException e) {
        return ResponseModel.error("该账号无后台登录权限");
      } finally {
        token.clear();
      }
    }
  }

  /**
   * 退出
   */
  @RequestMapping("/logout.htm")
  public ModelAndView logout() {
    SecurityUtils.getSubject().logout();
    return new ModelAndView("redirect:/login.htm");
  }
}
