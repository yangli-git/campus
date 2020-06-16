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
							<legend>添加新管理员</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md9">
						<fieldset class="layui-elem-field">
							<legend>填入信息</legend>
							<div class="layui-field-box">
								<form id="reform" class="layui-form layui-form-pane"
									lay-filter="formFilter" action="admin/addAdmin.do" method="post">

									<div class="layui-form-item">
										<label class="layui-form-label">账号</label>
										<div class="layui-input-inline">
											<input type="text" name="account" lay-verify="account"
												placeholder="请输入" autocomplete="off" class="layui-input">
										</div>
										<div class="layui-form-mid layui-word-aux">注册成功后可以用此账号登录</div>
									</div>

									
									<div class="layui-form-item">
										<button class="layui-btn" lay-submit="reform"
											lay-filter="reform">提交</button>
									</div>
								</form>
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
			©  - 校园即时服务平台
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/layui/layui.all.js"></script>
	<script>
		layui.use([ 'form', 'laydate' ], function() {
			var form = layui.form,
				layer = layui.layer,
				laydate = layui.laydate;
	
			//日期
			laydate.render({
				elem : '#date'
			});
			laydate.render({
				elem : '#date1'
			});
	
			//自定义验证规则
			form.verify({
				account : function(value) {
					if (value.length < 5) {
						return '账号至少得5个字符啊';
					}
				}
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
