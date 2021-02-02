<!-- 共用头部模板 -->
<#include "../common/top.ftl"/>

<body>

<div class="layui-fluid">
  <div class="layui-row layui-col-space15">
    <div class="layui-col-md12">
      <div class="layui-row layui-col-space15">
        <div class="layui-col-md4">
          <div class="layui-card">
            <div class="layui-card-header">快捷方式</div>
            <div class="layui-card-body">

              <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                <div carousel-item>
                  <ul class="layui-row layui-col-space10">
                    <li class="layui-col-xs3">
                      <a lay-href="${request.contextPath}/order/list.htm">
                        <i class="layui-icon layui-icon-console"></i>
                        <cite>订单查询</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a lay-href="home/homepage2.html">
                        <i class="layui-icon layui-icon-chart"></i>
                        <cite>收款账户配置</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a lay-href="component/layer/list.html">
                        <i class="layui-icon layui-icon-template-1"></i>
                        <cite>弹层</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a layadmin-event="im">
                        <i class="layui-icon layui-icon-chat"></i>
                        <cite>聊天</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a lay-href="component/progress/index.html">
                        <i class="layui-icon layui-icon-find-fill"></i>
                        <cite>进度条</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a lay-href="app/workorder/list.html">
                        <i class="layui-icon layui-icon-survey"></i>
                        <cite>工单</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a lay-href="user/user/list.html">
                        <i class="layui-icon layui-icon-user"></i>
                        <cite>用户</cite>
                      </a>
                    </li>
                    <li class="layui-col-xs3">
                      <a lay-href="set/system/website.html">
                        <i class="layui-icon layui-icon-set"></i>
                        <cite>设置</cite>
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

            </div>
          </div>
        </div>
        <div class="layui-col-md4">
          <div class="layui-card">
            <div class="layui-card-header">我的钱包</div>
            <div class="layui-card-body">

              <div class="layui-carousel layadmin-carousel layadmin-backlog">
                <div carousel-item>
                  <ul class="layui-row layui-col-space10">
                    <li class="layui-col-xs6">
                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                        <h3>今日订单总金额</h3>
                        <p><cite>10066</cite></p>
                      </a>
                    </li>
                    <li class="layui-col-xs6">
                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                        <h3>今日利润</h3>
                        <p><cite>20</cite></p>
                      </a>
                    </li>

                    <li class="layui-col-xs6">
                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                        <h3>剩余下发金额</h3>
                        <p><cite>102</cite></p>
                      </a>
                    </li>
                    <li class="layui-col-xs6">
                      <a href="javascript:;" onclick="layer.tips('不跳转', this, {tips: 3});" class="layadmin-backlog-body">
                        <h3>剩余下发金额</h3>
                        <p><cite>99</cite></p>
                      </a>
                    </li>
                  </ul>
                  <ul class="layui-row layui-col-space10">
                    <li class="layui-col-xs6">
                      <a href="javascript:;" class="layadmin-backlog-body">
                        <h3>待审友情链接</h3>
                        <p><cite style="color: #FF5722;">5</cite></p>
                      </a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="layui-col-md4">
          <div class="layui-card">
            <div class="layui-card-header">版本信息1</div>
            <div class="layui-card-body layui-text">
              <table class="layui-table">
                <colgroup>
                  <col width="100">
                  <col>
                </colgroup>
                <tbody>
                <tr>
                  <td>当前版本</td>
                  <td>
                    <script type="text/html" template>
                      v{{ layui.admin.v }}
                      <a href="http://fly.layui.com/docs/3/" target="_blank" style="padding-left: 10px;">日志</a>
                    </script>
                    <a href="javascript:;" layadmin-event="update" style="padding-left: 5px;">检查更新</a>
                  </td>
                </tr>
                <tr>
                  <td>基于框架</td>
                  <td>
                    <script type="text/html" template>
                      layui-v{{ layui.v }}
                    </script>
                  </td>
                </tr>
                <tr>
                  <td>主要特色</td>
                  <td>零门槛 / 响应式 / 清爽 / 极简</td>
                </tr>
                <tr>
                  <td>获取渠道</td>
                  <td style="padding-bottom: 0;">
                    <div class="layui-btn-container">
                      <a href="http://www.layui.com/admin/" target="_blank" class="layui-btn layui-btn-danger">获取授权</a>
                      <a href="http://fly.layui.com/download/layuiAdmin/" target="_blank" class="layui-btn">立即下载</a>
                    </div>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="${request.contextPath}/static/lib/layuiadmin/layui/layui.js?t=1"></script>
<script>
  layui.config({
    base: '${request.contextPath}/static/lib/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index','console']);
</script>
</body>

<!-- 底部共用模板 -->
<#include "../common/bottom.ftl"/>
