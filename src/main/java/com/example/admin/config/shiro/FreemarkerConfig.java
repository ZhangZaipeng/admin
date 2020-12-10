package com.example.admin.config.shiro;

import com.example.admin.config.freemarker.ShiroTags;
import freemarker.template.TemplateModelException;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * Title:      FreemarkerConfig
 *
 * @version V1.0 Description: freemarker配置shiro
 * @date 2018年7月26日
 */
@Configuration
public class FreemarkerConfig {

  @Autowired
  private FreeMarkerConfigurer freeMarkerConfigurer;

  @PostConstruct
  public void setSharedVariable() throws TemplateModelException {
    freemarker.template.Configuration configuration = freeMarkerConfigurer.getConfiguration();
    configuration.setSharedVariable("shiro", new ShiroTags());
  }
}
