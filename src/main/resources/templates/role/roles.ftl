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
          <button class="layui-btn layuiadmin-btn-admin" lay-submit
                  lay-filter="LAY-user-back-search">
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

      <table id="LAY-user-back-role" lay-filter="LAY-user-back-role"></table>
      <script type="text/html" id="buttonTpl">
        {{#  if(d.check == true){ }}
        <button class="layui-btn layui-btn-xs">已审核</button>
        {{#  } else { }}
        <button class="layui-btn layui-btn-primary layui-btn-xs">未审核</button>
        {{#  } }}
      </script>
      <script type="text/html" id="table-useradmin-admin">
        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
              class="layui-icon layui-icon-edit"></i>编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
              class="layui-icon layui-icon-delete"></i>删除</a>
      </script>
    </div>
  </div>
</div>

<script src="${request.contextPath}/static/lib/layuiadmin/layui/layui.js?t=1"></script>

<script>
  layui.config({
    base: '${request.contextPath}/static/lib/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'useradmin', 'table'], function () {
    var $ = layui.$
        , form = layui.form
        , table = layui.table;

    //搜索角色
    form.on('select(LAY-user-adminrole-type)', function (data) {
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
