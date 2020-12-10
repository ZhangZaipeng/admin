package com.example.admin.config.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * Created by zhangzp on 2018/8/20 0008.
 */
@Configuration
public class SpringInterceptorRegister extends WebMvcConfigurerAdapter {

  @Autowired
  private LoginInterceptor loginInterceptor;

  // 添加spring中的拦截器  excludePathPatterns 可以排除
  @Override
  public void addInterceptors(InterceptorRegistry registry) {

    registry.addInterceptor(loginInterceptor)
        .addPathPatterns("/trade/stock/**", "/trade/gold/**");

    registry.addInterceptor(loginInterceptor)
            .addPathPatterns("/wap/info/**");

    super.addInterceptors(registry);
  }

}
