<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="user_menu.jsp"%>
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
							<legend>已发布任务</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<fieldset class="layui-elem-field" style="padding: 20px;">
							<legend>已发布任务</legend>
							<c:forEach items="${list }" var="task">
								<div style="margin-left: 20px;margin-right: 30px;margin-top: 20px;">
									<c:if test="${task.state==0 }">
										<span class="layui-badge layui-bg-blue">待解决</span>
									</c:if>
									<c:if test="${task.state==1 }">
										<span class="layui-badge layui-bg-gray">已关闭</span>
									</c:if>
									<c:if test="${task.state==2 }">
										<span class="layui-badge layui-bg-green">解决中</span>
									</c:if>
									<c:if test="${task.state==3 }">
										<span class="layui-badge layui-bg-orange">已完成</span>
									</c:if>
								</div>
								<fieldset class="layui-elem-field layui-field-title"
									style="margin: 20px;margin-bottom: 5px;margin-top: 5px;">
									<legend><a>${task.taskName }</a></legend>
								</fieldset>
								<div style="margin-left: 20px;margin-right: 30px;">
									<span class="layui-badge layui-bg-gray">详细描述</span>
									<span class="layui-badge layui-bg-gray">发布时间：<fmt:formatDate value="${task.addTime }" pattern=" yyyy-MM-dd HH:mm:ss" /></span>
									<c:if test="${task.state!=0 }">
										<span class="layui-badge layui-bg-gray">结束时间：<fmt:formatDate value="${task.endTime }" pattern=" yyyy-MM-dd HH:mm:ss" /></span>
									</c:if>
									<span class="layui-badge layui-bg-gray">奖励：${task.reward }</span>
								</div>
								<div style="margin-left: 30px;margin-right: 30px;margin-top: 10px;">
									<h3>${task.taskContext }</h3>
								</div>
								<div style="margin-left: 30px;margin-right: 30px;margin-top: 10px;margin-bottom: 30px;">
									<c:if test="${task.state==0 }">
										<a href="task/taskClose.do?tidstr=${task.taskId }" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius">取消该任务</a>
									</c:if>
									<c:if test="${task.state==1 }">
										<button class="layui-btn layui-btn-sm layui-btn-disabled layui-btn-radius">任务已关闭</button>
									</c:if>
									<c:if test="${task.state==2 }">
										<a onclick="getAUser(${task.acceptUserId })" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius">查看接受者信息</a>
										<a href="task/taskOk.do?tidstr=${task.taskId }" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius">确认任务完成</a>
									</c:if>
									<c:if test="${task.state==3 }">
										<a onclick="getAUser(${task.acceptUserId })" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius">查看接受者信息</a>
										<button class="layui-btn layui-btn-sm layui-btn-disabled layui-btn-radius">任务已完成</button>
									</c:if>
								</div>
								
							</c:forEach>
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
				//console.log(elem)
				layer.msg(elem.text());
			});
		});
	</script>
	<script>
		function getAUser(stuId){
			//iframe层
			layer.open({
		      type: 2,
		      title: '该用户信息',
		      shadeClose: true,
		      shade: false,
		      area: ['1000px', '600px'],
		      content: 'common/getUser.do?stuIdStr='+stuId
		    });
		}
	</script>
	
</body>
</html>
