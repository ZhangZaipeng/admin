package com.example.admin.config;

import com.example.admin.common.tools.StringUtils;
import com.example.admin.common.exception.ResultErrException;
import com.example.admin.common.response.ResponseCode;
import com.example.admin.common.response.ResponseModel;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.authz.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@ControllerAdvice
public class GlobalExceptionHandler {

  private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
  private static final String URL_SUFFIX_HTML = ".htm";

  @ExceptionHandler({
      ResultErrException.class
  })
  public ModelAndView resolveException(HttpServletRequest request, Exception ex) {
    String url = request.getRequestURL().toString();
    if (url.endsWith(URL_SUFFIX_HTML)) {
      ModelAndView modelAndView = new ModelAndView("/error");
      modelAndView.addObject("message", "error");
      return modelAndView;
    } else {
      ResponseModel model = ResponseModel.error(ResponseCode.API_99999).setMsg("网络不给力呀,请稍后重试!");
      if (ex instanceof ResultErrException) {
        ResultErrException resultErrException = (ResultErrException)ex;
        model = ResponseModel.getModel(resultErrException);
      }

      ModelAndView modelAndView = new ModelAndView(new MappingJackson2JsonView());

      modelAndView.addAllObjects(model);

      return modelAndView;
    }
  }

  @ExceptionHandler({
      Exception.class,
  })
  public ModelAndView resolveException1(HttpServletRequest request, Exception ex) {

    ByteArrayOutputStream buf = null;
    try {
      // 打印堆栈日志到日志文件中
      buf = new ByteArrayOutputStream();
      ex.printStackTrace(new java.io.PrintWriter(buf, true));
      String  expMessage = buf.toString();
      logger.error("GlobalExceptionHandler,捕获异常:"+ ex.getMessage() + "; eString:" + expMessage);

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      try {
        if (buf!=null) {
          buf.close();
        }
      } catch (IOException e) {
        e.printStackTrace();
      }
    }

    String msg = "未知错误";
    if (!StringUtils.isEmpty(ex.getMessage())) {
      msg = ex.getMessage();
    }

    if (!isAjax(request)) {
      ModelAndView modelAndView = new ModelAndView();
      if (ex instanceof UnauthorizedException) {
        modelAndView.addObject("msg", "无访问权限");
        modelAndView.setViewName("public/403");
      } else {
        modelAndView.addObject("msg", msg);
        modelAndView.setViewName("public/error");
      }
      return modelAndView;
    } else {

      ModelAndView modelAndView = new ModelAndView(new MappingJackson2JsonView());
      if (ex instanceof UnauthorizedException) {
        ResponseModel model = ResponseModel.error(ResponseCode.AUTH_LOGIN).setMsg("无访问权限!");
        modelAndView.addAllObjects(model);
      } else {
        ResponseModel model = ResponseModel.error(ResponseCode.API_99999).setMsg("网络不给力呀,请稍后重试!");
        modelAndView.addAllObjects(model);
      }

      return modelAndView;
    }
  }


  private boolean isAjax(HttpServletRequest req) {
    return (req.getHeader("X-Requested-With") != null) && "XMLHttpRequest".equals(req.getHeader("X-Requested-With").toString());
  }
}
