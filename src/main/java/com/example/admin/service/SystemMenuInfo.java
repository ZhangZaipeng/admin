package com.example.admin.service;

/**
 * @Description ：
 * @Tauthor ZhangZaipeng
 */
public class SystemMenuInfo {

  private Long mainPerId;
  private String mainMenuName;
  private String mainIcon;
  private Long subPerId;
  private String subMenuName;
  private String subIcon;
  private String permission;
  private String perUrl;
  private String icon;
  private String remark;

  public String getMainIcon() {
    return mainIcon;
  }

  public void setMainIcon(String mainIcon) {
    this.mainIcon = mainIcon;
  }

  public String getSubIcon() {
    return subIcon;
  }

  public void setSubIcon(String subIcon) {
    this.subIcon = subIcon;
  }

  public Long getMainPerId() {
    return mainPerId;
  }

  public void setMainPerId(Long mainPerId) {
    this.mainPerId = mainPerId;
  }

  public String getMainMenuName() {
    return mainMenuName;
  }

  public void setMainMenuName(String mainMenuName) {
    this.mainMenuName = mainMenuName;
  }

  public Long getSubPerId() {
    return subPerId;
  }

  public void setSubPerId(Long subPerId) {
    this.subPerId = subPerId;
  }

  public String getSubMenuName() {
    return subMenuName;
  }

  public void setSubMenuName(String subMenuName) {
    this.subMenuName = subMenuName;
  }

  public String getPermission() {
    return permission;
  }

  public void setPermission(String permission) {
    this.permission = permission;
  }

  public String getPerUrl() {
    return perUrl;
  }

  public void setPerUrl(String perUrl) {
    this.perUrl = perUrl;
  }

  public String getIcon() {
    return icon;
  }

  public void setIcon(String icon) {
    this.icon = icon;
  }

  public String getRemark() {
    return remark;
  }

  public void setRemark(String remark) {
    this.remark = remark;
  }
}
