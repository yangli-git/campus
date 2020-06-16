<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>密码设置</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
    <c:if test="${empty nowUser }">
        <script type="text/javascript">
            alert("请先登录");
            window.location.href="<%=basePath%>login.jsp";
        </script>
    </c:if>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">校园即时服务平台</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">任务中心</a></li>
            <li class="layui-nav-item"><a href="userIndex.jsp">个人中心</a></li>

        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item"><a href="javascript:;">

                ${nowUser.name } </a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="userIndex.jsp">个人信息</a>
                    </dd>
                    <dd>
                        <a href="userUpdate.jsp">资料修改</a>
                    </dd>
                    <dd>
                        <a href="userPassword.jsp">安全设置</a>
                    </dd>
                </dl></li>
            <li class="layui-nav-item"><a href="common/logout.do">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test">

                <li class="layui-nav-item"><a href="">校园即时服务平台</a></li>

                <li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">任务管理</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="task/getUserTask.do">已发布任务</a>
                        </dd>
                        <dd>
                            <a href="/task/getUserATask.do">已接受任务</a>
                        </dd>
                        <dd>
                            <a href="userNewTask.jsp">发布新任务</a>
                        </dd>
                    </dl></li>

                <li class="layui-nav-item layui-nav-itemed"><a class=""
                                                               href="javascript:;">个人中心</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="userIndex.jsp">个人信息</a>
                        </dd>
                        <dd>
                            <a href="userUpdate.jsp">资料修改</a>
                        </dd>
                        <dd class="layui-this">
                            <a href="userPassword.jsp">安全设置</a>
                        </dd>
                    </dl></li>

            </ul>

        </div>
    </div>