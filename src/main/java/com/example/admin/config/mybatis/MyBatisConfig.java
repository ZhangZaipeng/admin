package com.example.admin.config.mybatis;

import com.alibaba.druid.pool.DruidDataSource;
import com.github.pagehelper.PageInterceptor;
import java.util.Properties;
import javax.sql.DataSource;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

/**
 * Created by zhangzp on 2018/8/27.
 */
@Configuration
public class MyBatisConfig {
  private static final String MAPPER_LOCATION = "classpath*:com/example/admin/**/*Mapper.xml";

  @Bean
  @ConfigurationProperties(prefix = "spring.datasource")
  public DataSource dataSource() {
    return new DruidDataSource();
  }

  @Bean(name = "sqlSessionFactory")
  public SqlSessionFactory sqlSessionFactory() throws Exception {
    final SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
    sqlSessionFactoryBean.setDataSource(dataSource());
    sqlSessionFactoryBean.setMapperLocations(
        new PathMatchingResourcePatternResolver()
            .getResources(MAPPER_LOCATION));

    Properties p = new Properties();
    p.setProperty("helperDialect", "MySQL");

    PageInterceptor pageInterceptor = new PageInterceptor();
    pageInterceptor.setProperties(p);

    // 插件
    sqlSessionFactoryBean.setPlugins(new Interceptor[]{pageInterceptor});

    return sqlSessionFactoryBean.getObject();
  }
}
