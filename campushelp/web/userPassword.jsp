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
							<legend>安全设置</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md9">
						<fieldset class="layui-elem-field">
							<legend>密码修改</legend>
							<form id="reform" class="layui-form layui-form-pane" style="padding: 30px;"
								action="user/updatePwd.do" method="post">

								<input type="hidden" name="stuId" lay-verify="stuId"
									value="${nowUser.stuId }">

								<div class="layui-form-item">
									<label class="layui-form-label">原密码</label>
									<div class="layui-input-inline">
										<input type="password" name="oldPassword" placeholder="请输入密码"
											lay-verify="oldpassword" autocomplete="off"
											class="layui-input">
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">新密码</label>
									<div class="layui-input-inline">
										<input type="password" name="password" placeholder="请输入密码"
											lay-verify="password" autocomplete="off" class="layui-input">
									</div>
								</div>

								<div class="layui-form-item">
									<button class="layui-btn" lay-submit="reform"
										lay-filter="reform">保存</button>
								</div>
							</form>
						</fieldset>

					</div>
					<div class="layui-col-md1">&nbsp;</div>
				</div>

			</div>

		</div>
		
		<c:if test="${!empty msg }">
			<c:if test="${!empty flag }">
				<script type="text/javascript">
					layer.msg("${msg }", { icon: 1, offset: "auto", time:1000 });
					window.location.href="common/logout.do"; 
				</script>
			</c:if>
			<c:if test="${empty flag }">
				<script type="text/javascript">
					layer.msg("${msg }", { icon: 1, offset: "auto", time:1000 });
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
	
			//自定义验证规则
			form.verify({
				stuId : function(value) {
					if (value.length < 1) {
						return '编号错误';
					}
				},
				oldpassword : [ /(.+){6,12}$/, '密码都是6到12位的哦' ],
				password : [ /(.+){6,12}$/, '新密码必须6到12位' ]
			});
	
			//监听提交
			form.on('submit(reform)', function(data) {
				/*layer.alert(JSON.stringify(data.field), {
					title : '最终的提交信息'
				})*/
			//return false;
			});
	
	
		});
	</script>
</body>
</html>
