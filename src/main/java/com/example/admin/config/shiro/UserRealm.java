package com.example.admin.config.shiro;

import com.example.admin.common.tools.YvanUtil;
import com.example.admin.entity.SystemAdmin;
import com.example.admin.mapper.SystemAdminMapper;
import com.example.admin.service.SystemAdminService;
import java.util.ArrayList;
import java.util.List;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Description
 * @Author sgl
 * @Date 2018-06-11 17:07
 */
public class UserRealm extends AuthorizingRealm {

  private static final Logger LOGGER = LoggerFactory.getLogger(UserRealm.class);

  @Autowired
  private SystemAdminService systemAdminService;

  @Autowired
  private SystemAdminMapper systemAdminMapper;

  @Override
  protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    SystemAdmin systemAdmin = (SystemAdmin) principals.getPrimaryPrincipal();

    List<String> sysPermissions = systemAdminService.findAdminPermission(systemAdmin.getAdminId());

    SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
    info.addStringPermissions(sysPermissions);

    LOGGER.info("doGetAuthorizationInfo sysPermissions " + YvanUtil.toJson(sysPermissions));

    return info;
  }

  @Override
  protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
      throws AuthenticationException {
    UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;

    SystemAdmin systemAdmin = systemAdminMapper.findByAdminName(token.getUsername());

    if (systemAdmin == null) {
      return null;
    }

    LOGGER.info("doGetAuthenticationInfo sysUser -> " + YvanUtil.toJson(systemAdmin));

    return new SimpleAuthenticationInfo(systemAdmin, systemAdmin.getPassword(),
        systemAdmin.getAdminName());
  }
}
