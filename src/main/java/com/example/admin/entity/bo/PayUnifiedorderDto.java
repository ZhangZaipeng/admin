package com.example.admin.entity.bo;

import java.io.Serializable;

public class PayUnifiedorderDto implements Serializable {
  private String orderId;
  private String accesUrl;

  public String getOrderId() {
    return orderId;
  }

  public void setOrderId(String orderId) {
    this.orderId = orderId;
  }

  public String getAccesUrl() {
    return accesUrl;
  }

  public void setAccesUrl(String accesUrl) {
    this.accesUrl = accesUrl;
  }
}
