<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>校园即时服务平台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<c:if test="${!empty loginFlag }">
	<script type="text/javascript">
		window.location = "<%=basePath%>";
	</script>
</c:if>
<link rel="stylesheet" href="<%=basePath%>layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>layui/css/global.css">
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<div class="layui-logo">校园即时服务平台</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a href="/task/list.do">任务中心</a></li>
				<c:if test="${!empty nowUser }">
					<li class="layui-nav-item"><a href="userIndex.jsp">个人中心</a></li>
				</c:if>
			</ul>
			<ul class="layui-nav layui-layout-right">
				<c:if test="${!empty nowUser }">
					<li class="layui-nav-item"><a href="javascript:;">${nowUser.name }</a>
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
				</c:if>
				<c:if test="${empty nowUser }">
					<li class="layui-nav-item"><a href="register.jsp">注册</a></li>
					<li class="layui-nav-item"><a href="login.jsp">登录</a></li>
				</c:if>

			</ul>
		</div>

		<div class="layui-side layui-bg-black">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="test">

					<li class="layui-nav-item layui-this"><a href="">校园即时服务平台</a></li>
					<c:if test="${!empty nowUser }">
						<li class="layui-nav-item layui-nav-itemed"><a
							href="javascript:;">任务管理</a>
							<dl class="layui-nav-child">
								<dd>
									<a href="task/getUserTask.do">已发布任务</a>
								</dd>
								<dd>
									<a href="task/getUserATask.do">已接受任务</a>
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
								<dd>
									<a href="userPassword.jsp">安全设置</a>
								</dd>
							</dl></li>
					</c:if>

				</ul>

			</div>
		</div>

		<!-- 内容主体区域-->
		<div class="layui-body ">

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
							<legend>任务平台</legend>
						</fieldset>
					</div>
				</div>


				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<form class="layui-form layui-form-pane" lay-filter="formFilter"
							method="post" action="task/list.do">

							<div class="layui-form-item">
								<div class="layui-inline" style="margin-left: 10%">
									<label class="layui-form-label">关键词</label>
									<div class="layui-input-block">
										<input type="text" name="words" autocomplete="off"
											class="layui-input" value="${words}">
									</div>
								</div>
								<div class="layui-input-inline">
									<label class="layui-form-label">学校</label>
									<div class="layui-input-block" style="width: 80%">
										<select id="schoolIdStr" name="schoolIdStr"
												lay-filter="schoolFilter0">
											<option value="-1" selected="true">未选择</option>
										</select>
									</div>
								</div>

								<button class="layui-btn" lay-submit="seform"
									lay-filter="seform">搜索</button>

							</div>

						</form>
					</div>
					<div class="layui-col-md1">&nbsp;</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<fieldset class="layui-elem-field">
							<legend>任务</legend>
							<div class="layui-field-box" style="padding: 30px;">
								<div class="layui-row">
									<div class="layui-col-md12">
										<div class="fly-panel" style="margin-bottom: 0;">

											<div class="fly-panel-title fly-filter">
												<a class="layui-this">任务</a> <span class="fly-mid"></span> <a>${words }</a>
												<span class="fly-mid"></span> <span
													class="fly-filter-right layui-hide-xs"> <a
													class="layui-this">最新</a>
												</span>
											</div>

											<ul class="fly-list">
												<c:forEach items="${p.list }" var="task">

													<li style="padding-left: 15px;">
														<h2>
															<a class="layui-badge">
																<c:if test="${task.state == -1}">暂存</c:if>
																<c:if test="${task.state == 0}">已完成</c:if>
																<c:if test="${task.state == 1}">进行中</c:if>
																<c:if test="${task.state == 2}">待解决</c:if>
															</a> <a
																onclick="getTask(${task.taskId })">${task.taskName }</a>
														</h2>
														<div class="fly-list-info">
															<a onclick="getPUser(${task.publishUserId })" link> <cite>${task.publishUserName }</cite></a>
															<span><fmt:formatDate value="${task.addTime }"
																	pattern=" yyyy-MM-dd HH:mm:ss" /></span> <span
																class="fly-list-kiss layui-hide-xs"> <i
																class="layui-icon">&#xe65e;</i> ${task.reward }
															</span> <span class="fly-list-nums"> <i
																class="layui-icon">&#xe62c;</i>
															</span>
														</div>
													</li>

												</c:forEach>
											</ul>

											<div style="text-align: center">
												<div id="test1"></div>
											</div>

										</div>

									</div>
								</div>

							</div>
						</fieldset>

					</div>
					<div class="layui-col-md1">&nbsp;</div>
				</div>

			</div>

		</div>

		<c:if test="${!empty msg }">
			<script type="text/javascript">
				alert("${msg }");
			</script>
		</c:if>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			©  - 校园即时服务平台办公电话：6666666
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/layui/layui.all.js"></script>
	<script>
		//JavaScript代码区域
		layui.use('element', function() {
			var element = layui.element;
			//监听导航点击
			element.on('nav(test)', function(elem) {
				layer.msg(elem.text());
			});
		});
	</script>
	<script type="text/javascript">
		var form;
		layui.use([ 'layedit', 'form' ], function() {
			form = layui.form;
	
			//自定义验证规则
			form.verify({
				schoolIdStr : function(value) {
					if (value.length < 1) {
						return '学校选择出现问题';
					}
				}
			});
	
			//监听提交
			form.on('submit(seform)', function(data) {
				/*layer.alert(JSON.stringify(data.field), {
					title : '最终的提交信息'
				})*/
			//return false;
			});
	
		});
		//加载layui中的jq
		layui.use([ 'jquery', 'layer' ], function() {
			var $ = layui.$, //重点处
				layer = layui.layer;
	
			$(function() {
				$.post(
					"common/getAllSchools.do",
					{},
					function(data) {
						var obj = JSON.parse(data);
						var str = "";
						for (var i = 0; i < obj.length; i++) {
							var optionStr = "";
							optionStr += "<option value='" + obj[i].schoolId + "'>" + obj[i].name + "</option>";
							$("#schoolIdStr").append(optionStr);
							$("#schoolIdStr").val(${schoolIdStr});
							form.render('select', 'formFilter');//加载完毕后更新表单显示（统一样式）
						}
					}
				);
			});
		});
	</script>
	<script>
		function getPUser(stuId) {
			//iframe层
			layer.open({
				type : 2,
				title : '该用户信息',
				shadeClose : true,
				shade : false,
				area : [ '1000px', '600px' ],
				content : 'common/getUser.do?stuIdStr=' + stuId
			});
		}
		function getTask(taskId) {
			//iframe层
			layer.open({
				type : 2,
				title : '该任务信息',
				shadeClose : true,
				shade : false,
				area : [ '1000px', '600px' ],
				content : 'task/getTaskInfo.do?tidStr=' + taskId
			});
		}
	</script>
	<script type="text/javascript">
		layui.use('laypage', function() {
			var laypage = layui.laypage;

			//执行一个laypage实例
			laypage.render({
				elem : 'test1', //注意，这里的 test1 是 ID，不用加 # 号
				count : ${p.total} ,//数据总数，从服务端得到
				limit : ${p.pageSize} ,
				curr: ${p.pageNum } ,
				jump: function(obj,first){//点击页码出发的事件
                	if(first!=true){//是否首次进入页面
                    	var currentPage = obj.curr;//获取点击的页码
                    	window.location.href ="<%=path%>/task/list.do?words=${words }&schoolIdStr=${schoolIdStr }&page="+currentPage;
                	}
                }
			});
		});
	</script>
</body>
</html>
