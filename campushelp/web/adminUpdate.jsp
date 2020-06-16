<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="admin_menu.jsp"%>
<!-- 内容主体区域-->
<div class="layui-body">

    <div style="padding: 30px;" class="layui-fluid">
        <div class="layui-row">
            <div class="layui-col-md12">
                <span class="layui-badge-dot"></span> <span
                    class="layui-badge-dot layui-bg-orange"></span> <span
                    class="layui-badge-dot layui-bg-green"></span> <span
                    class="layui-badge-dot layui-bg-cyan"></span> <span
                    class="layui-badge-dot layui-bg-blue"></span> <span
                    class="layui-badge-dot layui-bg-black"></span> <span
                    class="layui-badge-dot layui-bg-gray"></span>
                <fieldset class="layui-elem-field layui-field-title"
                          style="margin-top: 30px;">
                    <legend>资料修改设置</legend>
                </fieldset>
            </div>
        </div>


        <div class="layui-row">
            <div class="layui-col-md1">&nbsp;</div>
            <div class="layui-col-md9">
                <fieldset class="layui-elem-field">
                    <legend>资料修改</legend>
                    <form id="reform" class="layui-form layui-form-pane" lay-filter="formFilter"
                          action="/admin/update.do" method="post" style="padding: 30px;">


                        <div class="layui-form-item">
                            <label class="layui-form-label">编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="AId" lay-verify="name"
                                       disabled="disabled" autocomplete="off" class="layui-input"
                                       value="${nowAdmin.AId }">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">登录账号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="account" lay-verify="name"
                                       autocomplete="off" class="layui-input"
                                       value="${nowAdmin.account }">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" lay-verify="name"
                                       autocomplete="off" class="layui-input"
                                       value="${nowAdmin.name }">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">注册时间</label>
                            <div class="layui-input-inline">
                                <input type="text" name="addTime" lay-verify="studentId"
                                       disabled="disabled" autocomplete="off" class="layui-input"
                                       value="<fmt:formatDate value="${nowAdmin.addTime }"
                                           pattern=" yyyy-MM-dd HH:mm:ss" />">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="state" lay-verify="name"
                                       disabled="disabled" autocomplete="off" class="layui-input"
                                       value="<c:if test="${nowAdmin.state==0 }">
                            正常
                        </c:if> <c:if test="${nowAdmin.state!=0 }">
                        被限制
                    </c:if>">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <button class="layui-btn" lay-submit="reform"
                                    lay-filter="reform">保存</button>
                        </div>
                    </form>
                    <form action="/admin/adminCancel.do" method="post" style="float: left;position:relative;left:150px;bottom: 84px;">
                        <button name="AId" class="layui-btn"  value="${nowAdmin.AId}">注销</button>
                    </form>
                </fieldset>

            </div>
            <div class="layui-col-md1">&nbsp;</div>
        </div>

    </div>

</div>
<%--<c:if test="${!empty msg }">--%>
<%--    <script type="text/javascript">--%>
<%--        alert("${msg }");--%>
<%--    </script>--%>
<%--</c:if>--%>
<c:if test="${!empty msg }">
    <c:if test="${!empty flag }">
        <script type="text/javascript">
            alert("${msg }");
            window.location.href="common/logout.do";
        </script>
    </c:if>
    <c:if test="${empty flag }">
        <script type="text/javascript">
            alert("${msg}");
            window.location.href="common/logout.do";
        </script>
    </c:if>
</c:if>

<div class="layui-footer">
    <!-- 底部固定区域 -->
    ©  - 校园即时服务平台办公电话：6666666
</div>
</div>
<script src="${pageContext.request.contextPath }/layui/layui.all.js"></script>
<script>
    layui.use([ 'form' ], function() {
        var form = layui.form,
            layer = layui.layer;

        // //自定义验证规则
        // form.verify({
        //     studentId : function(value) {
        //         if (value.length < 5) {
        //             return '学号至少得5个字符啊';
        //         }
        //     },
        // });

    });
</script>