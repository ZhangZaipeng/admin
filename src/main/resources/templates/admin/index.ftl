<!-- 共用头部模板 -->
<#include "../common/top.ftl"/>

<body class="layui-layout-body" layadmin-themealias="green-header">
<div id="LAY_app">
  <div class="layui-layout layui-layout-admin">
    <div class="layui-header">
      <!-- 头部区域 -->
      <ul class="layui-nav layui-layout-left">
        <li class="layui-nav-item layadmin-flexible" lay-unselect>
          <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
            <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
          </a>
        </li>
      </ul>
      <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
        <li class="layui-nav-item" lay-unselect>
          <a href="javascript:;" layadmin-event="refresh" title="刷新">
            <i class="layui-icon layui-icon-refresh-3"></i>
          </a>
        </li>
        <li class="layui-nav-item layui-hide-xs" lay-unselect>
          <a href="javascript:;" layadmin-event="theme">
            <i class="layui-icon layui-icon-theme"></i>
          </a>
        </li>
        <li class="layui-nav-item layui-hide-xs" lay-unselect>
          <a href="javascript:;" layadmin-event="note">
            <i class="layui-icon layui-icon-note"></i>
          </a>
        </li>
        <li class="layui-nav-item layui-hide-xs" lay-unselect>
          <a href="javascript:;" layadmin-event="fullscreen">
            <i class="layui-icon layui-icon-screen-full"></i>
          </a>
        </li>
        <li class="layui-nav-item" lay-unselect>
          <a href="javascript:;">
            <cite>${admin.realName!""}</cite>
          </a>
        </li>

        <li class="layui-nav-item" lay-unselect>
          <a href="javascript:;"><i class="layui-icon layui-icon-logout"></i></a>
        </li>
      </ul>
    </div>

    <!-- 侧边菜单 -->
    <div class="layui-side layui-side-menu">
      <div class="layui-side-scroll">
        <div class="layui-logo" lay-href="home/console.html">
          <span>系统</span>
        </div>

        <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu"
            lay-filter="layadmin-system-side-menu">
            <#assign mainPerId= -1>
            <#list systemMenuInfos as menuInfo>
            <#if mainPerId != menuInfo.mainPerId>
            <#if mainPerId gt 0></dl></li></#if>
          <li data-name="${menuInfo.mainMenuName!""}" class="layui-nav-item">
            <a href="javascript:;" lay-tips="主页" lay-direction="2">
              <i class="layui-icon ${menuInfo.mainIcon!""}"></i>
              <cite>${menuInfo.mainMenuName!""}</cite>
            </a>
            <dl class="layui-nav-child">
                </#if>
              <dd data-name="console" class="layui-this">
                <a lay-href="${request.contextPath}${menuInfo.perUrl!""}">
                    ${menuInfo.subMenuName!""}</a>
              </dd>
                <#assign mainPerId = menuInfo.mainPerId>
                </#list>
            </dl>
          </li>
        </ul>
      </div>
    </div>

    <!-- 页面标签 -->
    <div class="layadmin-pagetabs" id="LAY_app_tabs">
      <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
      <div class="layui-icon layadmin-tabs-control layui-icon-next"
           layadmin-event="rightPage"></div>
      <div class="layui-icon layadmin-tabs-control layui-icon-down">
        <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
          <li class="layui-nav-item" lay-unselect>
            <a href="javascript:;"></a>
            <dl class="layui-nav-child layui-anim-fadein">
              <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
              <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
              <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
            </dl>
          </li>
        </ul>
      </div>
      <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
        <ul class="layui-tab-title" id="LAY_app_tabsheader">
          <li lay-id="home/console.html" lay-attr="home/console.html" class="layui-this"><i
                class="layui-icon layui-icon-home"></i></li>
        </ul>
      </div>
    </div>


    <!-- 主体内容 -->
    <div class="layui-body" id="LAY_app_body">
      <div class="layadmin-tabsbody-item layui-show">
        <iframe src="${request.contextPath}/console.htm" frameborder="0"
                class="layadmin-iframe"></iframe>
      </div>
    </div>

    <!-- 辅助元素，一般用于移动设备下遮罩 -->
    <div class="layadmin-body-shade" layadmin-event="shade"></div>
  </div>
</div>


<script src="${request.contextPath}/static/lib/layuiadmin/layui/layui.js"></script>

<script>
  layui.config({
    base: '${request.contextPath}/static/lib/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use('index');
</script>

</body>

<!-- 共用头部模板 -->
<#include "../common/bottom.ftl"/>


