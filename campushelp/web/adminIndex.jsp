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
							<legend>个人信息</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<fieldset class="layui-elem-field">
							<legend>信息</legend>
							<!--  <div class="layui-field-box">-->
								<table class="layui-table" lay-size="lg" lay-skin="line" style="margin-bottom: 0px;">
									<colgroup>
										<col width="150">
										<col width="200">
										<col>
									</colgroup>
									<thead>
										<tr>
											<th>&nbsp;</th>
											<th>&nbsp;</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>编号</td>
											<td>${nowAdmin.AId }</td>
										</tr>
										<tr>
											<td>登录账号</td>
											<td>${nowAdmin.account }</td>
										</tr>
										<tr>
											<td>姓名</td>
											<td>${nowAdmin.name }</td>
										</tr>
										<tr>
											<td>注册时间</td>
											<td><fmt:formatDate value="${nowAdmin.addTime }"
													pattern=" yyyy-MM-dd HH:mm:ss" /></td>
										</tr>
										<tr>
											<td>状态</td>
											<td><c:if test="${nowAdmin.state==0 }">
												正常
											  </c:if> <c:if test="${nowAdmin.state!=0 }">
												被限制
											  </c:if></td>
										</tr>
									</tbody>
								</table>
							<!--</div>-->
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
			©  - 校园即时服务平台
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
</body>
</html>
