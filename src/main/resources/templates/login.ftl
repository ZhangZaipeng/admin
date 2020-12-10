<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
  <meta charset="UTF-8">
    <#--<title th:text="${systemInfo.sitename}+'-后台登录'">逗逼阅读-后台管理-登陆</title>-->
  <title>后台管理</title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta http-equiv="Access-Control-Allow-Origin" content="*">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="format-detection" content="telephone=no">
  <link rel="stylesheet"
        href="${request.contextPath}/static/lib/layuiadmin/layui/css/layui.css"
        media="all">
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
  <style>
    html, body {
      width: 100%;
      height: 100%;
      overflow: hidden
    }

    body {
      background: #009688;
    }

    body:after {
      content: '';
      background-repeat: no-repeat;
      background-size: cover;
      -webkit-filter: blur(3px);
      -moz-filter: blur(3px);
      -o-filter: blur(3px);
      -ms-filter: blur(3px);
      filter: blur(3px);
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      z-index: -1;
    }

    .layui-container {
      width: 100%;
      height: 100%;
      overflow: hidden
    }

    .admin-login-background {
      width: 360px;
      height: 300px;
      position: absolute;
      left: 50%;
      top: 40%;
      margin-left: -180px;
      margin-top: -100px;
    }

    .logo-title {
      text-align: center;
      letter-spacing: 2px;
      padding: 14px 0;
    }

    .logo-title h1 {
      color: #009688;
      font-size: 25px;
      font-weight: bold;
    }

    .login-form {
      background-color: #fff;
      border: 1px solid #fff;
      border-radius: 3px;
      padding: 14px 20px;
      box-shadow: 0 0 8px #eeeeee;
    }

    .login-form .layui-form-item {
      position: relative;
    }

    .login-form .layui-form-item label {
      position: absolute;
      left: 1px;
      top: 1px;
      width: 38px;
      line-height: 36px;
      text-align: center;
      color: #d2d2d2;
    }

    .login-form .layui-form-item input {
      padding-left: 36px;
    }

    .captcha {
      width: 60%;
      display: inline-block;
    }

    .captcha-img {
      display: inline-block;
      width: 34%;
      float: right;
    }

    .captcha-img img {
      height: 34px;
      border: 1px solid #e6e6e6;
      height: 36px;
      width: 100%;
      cursor: pointer;
    }
  </style>
</head>
<body>
<div class="layui-container">
  <div class="admin-login-background">
    <div class="layui-form login-form">
      <form class="layui-form" action="${request.contextPath}/admin/login" method="post">
        <div class="layui-form-item logo-title">
          <h1>后台登录</h1>
        </div>
        <div class="layui-form-item">
          <label class="layui-icon layui-icon-username" for="username"></label>
          <input type="text" name="username" lay-verify="required" lay-reqtext="账号不能为空"
                 placeholder="用户名或者邮箱"
                 autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-item">
          <label class="layui-icon layui-icon-password" for="password"></label>
          <input type="password" name="password" lay-verify="required" lay-reqtext="密码不能为空"
                 placeholder="密码"
                 autocomplete="off" class="layui-input">
        </div>
        <div class="layui-form-item">
          <label class="layui-icon layui-icon-vercode" for="captcha"></label>
          <input type="text" name="captcha" lay-verify="required" lay-reqtext="验证码不能为空"
                 placeholder="图形验证码"
                 autocomplete="off" class="layui-input verification captcha">
          <div class="captcha-img">
            <img id="captchaPic" onclick="changeImg()">
          </div>
        </div>
        <div class="layui-form-item">
          <input type="checkbox" name="rememberMe" checked value="true" lay-skin="primary"
                 title="记住我">
        </div>
        <div class="layui-form-item">
          <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="login">登 入</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
<script src="${request.contextPath}/static/lib/layuimini/lib/jquery-3.4.1/jquery-3.4.1.min.js"
        charset="utf-8"></script>
<script src="${request.contextPath}/static/lib/layuiadmin/layui/layui.js" charset="utf-8"></script>
<script src="${request.contextPath}/static/lib/layuimini/lib/jq-module/jquery.particleground.min.js"
        charset="utf-8"></script>
<script>
  function changeImg() {
    var img = document.getElementById("captchaPic");
    // 浏览器有一个缓存特性,
    // 第一次从服务器获取图片，浏览器第二次发送请求时发现地址没有改变，就会使用第一次的图片，而不会真正发送请求
    // 为了让浏览器每次都把请求发送给服务器，给一个时间参数
    img.src = "${request.contextPath}/login/verificationCode.json?t=" + new Date().getTime();
    // 给src赋一个新值，就会向新值的地址发送一次请求
  }
</script>
<script type="text/javascript">

  var msg = "";

  layui.use(['form'], function () {
    var form = layui.form,
        layer = layui.layer;

    if (msg != null && msg != undefined && msg != '') {
      layer.alert(msg);
    }

    // 登录过期的时候，跳出ifram框架
    if (top.location != self.location) {
      top.location = self.location;
    }

    // 粒子线条背景
    $(document).ready(function () {
      $('.layui-container').particleground({
        dotColor: '#5cbdaa',
        lineColor: '#5cbdaa'
      });

      $(document).ready(function () {
        changeImg();
      });
    });

    // 进行登录操作
    form.on('submit(login)', function (data) {
      var index = layer.load();
      $.ajax({
        url: '${request.contextPath}/login/doLogin.json',
        method: 'post',
        data: data.field,
        dataType: 'json',
        success: function (result) {
          var msg = result.msg;
          var code = result.code;
          if (code == 200) {
            if (msg == null || msg == '' || msg == undefined) {
              message = '登录成功';
            }
            window.location = '${request.contextPath}/index.htm';
            return;
          }
          changeImg();
          if (msg == null || msg == '' || msg == undefined) {
            message = '登录失败:未知错误';
          }
          layer.close(index);
          layer.msg(msg);
        },
        error: function () {
          changeImg();
          layer.close(index);
          layer.msg('登录失败:网络异常，请稍后再试');
        }
      });
      return false;
    });
  });
</script>
</html>
