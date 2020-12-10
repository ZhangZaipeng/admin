package com.example.admin.config.shiro;

import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Description
 * @Author sgl
 * @Date 2018-06-11 17:23
 */
@Configuration
public class ShiroConfig {

  /**
   * 凭证匹配器
   */
  @Bean
  public BCCredentialsMatcher bcCredentialsMatcher() {
    BCCredentialsMatcher bcCredentialsMatcher = new BCCredentialsMatcher();
    return bcCredentialsMatcher;
  }

  /**
   * 自定义realm
   */
  @Bean
  public UserRealm userRealm() {
    UserRealm userRealm = new UserRealm();
    userRealm.setCredentialsMatcher(bcCredentialsMatcher());
    return userRealm;
  }

  /**
   * cookie对象;会话Cookie模板 ,默认为: JSESSIONID 问题: 与SERVLET容器名冲突,重新定义为sid或rememberMe，自定义
   */
  @Bean
  public SimpleCookie rememberMeCookie() {
    //这个参数是cookie的名称，对应前端的checkbox的name = rememberMe
    SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
    //setcookie的httponly属性如果设为true的话，会增加对xss防护的安全系数。它有以下特点：
    //setcookie()的第七个参数
    //设为true后，只能通过http访问，javascript无法访问
    //防止xss读取cookie
//        simpleCookie.setHttpOnly(true);
//        simpleCookie.setPath("/");
    //<!-- 记住我cookie生效时间30天 ,单位秒;-->
    simpleCookie.setMaxAge(2592000);
    return simpleCookie;
  }

  /**
   * cookie管理对象;记住我功能,rememberMe管理器
   */
  @Bean
  public CookieRememberMeManager rememberMeManager() {
    CookieRememberMeManager cookieRememberMeManager = new CookieRememberMeManager();
    cookieRememberMeManager.setCookie(rememberMeCookie());
    //rememberMe cookie加密的密钥 建议每个项目都不一样 默认AES算法 密钥长度(128 256 512 位)
    cookieRememberMeManager.setCipherKey(Base64.decode("4AvVhmFLUs0KTA3Kprsdag=="));
    return cookieRememberMeManager;
  }

  /**
   * 安全管理器 注：使用shiro-spring-boot-starter 1.4时，返回类型是SecurityManager会报错，直接引用shiro-spring则不报错
   */
  @Bean
  public DefaultWebSecurityManager securityManager() {
    DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();

    securityManager.setRealm(userRealm());
    securityManager.setRememberMeManager(rememberMeManager());

    return securityManager;
  }


  /**
   * 设置过滤规则
   */
  @Bean
  public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
    ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
    shiroFilterFactoryBean.setSecurityManager(securityManager);
    shiroFilterFactoryBean.setLoginUrl("/login/tologin.htm");
    shiroFilterFactoryBean.setSuccessUrl("/");
    shiroFilterFactoryBean.setUnauthorizedUrl("/unauth.htm");

    //注意此处使用的是LinkedHashMap，是有顺序的，shiro会按从上到下的顺序匹配验证，匹配了就不再继续验证
    //所以上面的url要苛刻，宽松的url要放在下面，尤其是"/**"要放到最下面，如果放前面的话其后的验证规则就没作用了。
    Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
    filterChainDefinitionMap.put("/static/**", "anon");
    filterChainDefinitionMap.put("/login/tologin.htm", "anon");
    filterChainDefinitionMap.put("/login/doLogin.json", "anon");
    filterChainDefinitionMap.put("/login/verificationCode.json", "anon");
    filterChainDefinitionMap.put("/ok.htm", "anon");
    filterChainDefinitionMap.put("/favicon.ico", "anon");
    filterChainDefinitionMap.put("/**", "authc");

    shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);

    return shiroFilterFactoryBean;
  }


}
