<!-- 共用头部模板 -->
<#include "../public/top.ftl"/>

<body>
<div class="layui-form" lay-filter="layuiadmin-form-role" id="layuiadmin-form-role"
     style="padding: 20px 30px 0 0;">

  <div class="layui-form-item">
    <label class="layui-form-label">权限范围</label>
    <div class="layui-form-item">
      <div id="test12" class="demo-tree-more"></div>
    </div>
  </div>


  <div class="layui-form-item">
    <label class="layui-form-label">具体描述</label>
    <div class="layui-input-block">
      <textarea type="text" name="descr" lay-verify="required" autocomplete="off"
                class="layui-textarea"></textarea>
    </div>
  </div>
  <div class="layui-form-item layui-hide">
    <button class="layui-btn" lay-submit lay-filter="LAY-user-role-submit"
            id="LAY-user-role-submit">提交
    </button>
  </div>
</div>

<script src="${request.contextPath}/static/lib/layuiadmin/layui/layui.js?t=1"></script>
<script>
  layui.config({
    base: '${request.contextPath}/static/lib/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['index', 'tree', 'form'], function () {
    var $ = layui.$, form = layui.form, tree = layui.tree;

    var data = [{
      title: '一级1'
      , id: 1
      , field: 'name1'
      , checked: true
      , spread: true
      , children: [{
        title: '二级1-1 可允许跳转'
        , id: 3
        , field: 'name11'
        , href: 'https://www.layui.com'
      }, {
        title: '二级1-2'
        , id: 4
        , spread: true
        , children: [{
          title: '三级1-2-1'
          , id: 9
          , field: ''
          , disabled: true
        }, {
          title: '三级1-2-2'
          , id: 10
          , field: ''
        }]
      }, {
        title: '二级1-3'
        , id: 20
        , field: ''
      }]
    }, {
      title: '一级2'
      , id: 2
      , field: ''
      , spread: true
      , children: [{
        title: '二级2-1'
        , id: 5
        , field: ''
        , spread: true
      }, {
        title: '二级2-2'
        , id: 6
        , field: ''
        , children: [{
          title: '三级2-2-1'
          , id: 13
          , field: ''
        }, {
          title: '三级2-2-2'
          , id: 14
          , field: ''
          , disabled: true
        }]
      }]
    }, {
      title: '一级3'
      , id: 16
      , field: ''
      , children: [{
        title: '二级3-1'
        , id: 17
        , field: ''
        , fixed: true
        , children: [{
          title: '三级3-1-1'
          , id: 18
          , field: ''
        }, {
          title: '三级3-1-2'
          , id: 19
          , field: ''
        }]
      }, {
        title: '二级3-2'
        , id: 27
        , field: ''
        , children: [{
          title: '三级3-2-1'
          , id: 28
          , field: ''
        }, {
          title: '三级3-2-2'
          , id: 29
          , field: ''
        }]
      }]
    }];

    //基本演示
    tree.render({
      elem: '#test12'
      , data: data
      , showCheckbox: true  //是否显示复选框
      , id: 'demoId1'
      , isJump: true //是否允许点击节点时弹出新窗口跳转
      , click: function (obj) {
        var data = obj.data;  //获取当前点击的节点数据
        layer.msg('状态：' + obj.state + '<br>节点数据：' + JSON.stringify(data));
      }
    });
  })
</script>
</body>

<!-- 共用头部模板 -->
<#include "../public/bottom.ftl"/>
