<!-- 共用头部模板 -->
<#include "../public/top.ftl"/>

<body>
<div class="layui-fluid">
  <div class="layui-card">
    <div class="layui-form layui-card-header layuiadmin-card-header-auto">
      <div class="layui-form-item">
        <div class="layui-inline">
          <label class="layui-form-label">角色筛选</label>
          <div class="layui-input-block">
            <input type="text" name="loginname" placeholder="角色名称" autocomplete="off"
                   class="layui-input">
          </div>
        </div>
        <div class="layui-inline">
          <button id="LAY-role-back-search" class="layui-btn layuiadmin-btn-admin" lay-submit
                  lay-filter="LAY-role-back-search">
            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
          </button>
        </div>
      </div>
    </div>
    <div class="layui-card-body">
      <div style="padding-bottom: 10px;">
        <button class="layui-btn layuiadmin-btn-role" data-type="batchdel">删除</button>
        <button class="layui-btn layuiadmin-btn-role" data-type="add">添加</button>
      </div>

      <table class="layui-hide" id="LAY-user-back-role" lay-filter="LAY-user-back-role"></table>

    </div>
  </div>
</div>

<script src="${request.contextPath}/static/lib/layuiadmin/layui/layui.js?t=1"></script>

<script>
  layui.config({
    base: '${request.contextPath}/static/lib/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'table'], function () {
    var $ = layui.$, form = layui.form, table = layui.table;

    // 方法级渲染
    table.render({
      elem: '#LAY-user-back-role'
      , url: '${request.contextPath}/system/roles.json'
      , parseData: function (res) {
        if (res.code == 200) {
          return {
            "code": 0, //解析接口状态
            "msg": res.msg, //解析提示文本
            "count": 200, //解析数据长度
            "data": res.data //解析数据列表
          };
        }

        return {
          "code": 100, //解析接口状态
          "msg": "数据请求错误", //解析提示文本
          "count": 0, //解析数据长度
          "data": null //解析数据列表
        };
      }
      , cols: [[
        {checkbox: true, fixed: true}
        , {field: 'roleId', title: 'ID', width: 80}
        , {field: 'roleCode', title: '权限编码', width: 100}
        , {field: 'roleName', title: '权限名称', width: 100}
        , {field: 'status', title: '状态', width: 80}
        , {field: 'remark', title: '描述'}
        , {field: 'createTime', title: '创建时间', width: 150}
        , {field: 'updateTime', title: '更新时间', width: 150}
      ]]
      , id: 'LAY-role-back-search'
      , page: true
      , height: 310
    });

    //搜索角色
    form.on('select(LAY-role-back-search)', function (data) {
      //执行重载
      table.reload('LAY-user-back-role', {
        where: {
          role: data.value
        }
      });
    });

    //事件
    var active = {
      batchdel: function () {
        var checkStatus = table.checkStatus('LAY-user-back-role')
            , checkData = checkStatus.data; //得到选中的数据

        if (checkData.length === 0) {
          return layer.msg('请选择数据');
        }

        layer.confirm('确定删除吗？', function (index) {

          //执行 Ajax 后重载
          /*
          admin.req({
            url: 'xxx'
            //,……
          });
          */
          table.reload('LAY-user-back-role');
          layer.msg('已删除');
        });
      },
      add: function () {
        layer.open({
          type: 2
          , title: '添加新角色'
          , content: '${request.contextPath}/system/roleform.htm'
          , area: ['500px', '480px']
          , btn: ['确定', '取消']
          , yes: function (index, layero) {
            var iframeWindow = window['layui-layer-iframe' + index]
                , submit = layero.find('iframe').contents().find("#LAY-user-role-submit");

            //监听提交
            iframeWindow.layui.form.on('submit(LAY-user-role-submit)', function (data) {
              var field = data.field; //获取提交的字段

              //提交 Ajax 成功后，静态更新表格中的数据
              //$.ajax({});
              table.reload('LAY-user-back-role');
              layer.close(index); //关闭弹层
            });

            submit.trigger('click');
          }
        });
      }
    }
    $('.layui-btn.layuiadmin-btn-role').on('click', function () {
      var type = $(this).data('type');
      active[type] ? active[type].call(this) : '';
    });
  });
</script>
</body>

<!-- 共用头部模板 -->
<#include "../public/bottom.ftl"/>
