<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="user_menu.jsp"%>
		</div>
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
							<legend>资料修改</legend>
						</fieldset>
					</div>
				</div>

				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md9">
						<fieldset class="layui-elem-field">
							<legend>资料修改</legend>
							<form id="reform" class="layui-form layui-form-pane" lay-filter="formFilter"
								action="user/update.do" method="post" style="padding: 30px;">

								<input type="hidden" name="stuId" value="${nowUser.stuId }">

								<div class="layui-form-item">
									<label class="layui-form-label">学号</label>
									<div class="layui-input-inline">
										<input type="text" name="studentId" lay-verify="studentId"
											disabled="disabled" autocomplete="off" class="layui-input"
											value="${nowUser.studentId }">
									</div>
								</div>

								<div class="layui-form-item">
									<label class="layui-form-label">姓名</label>
									<div class="layui-input-inline">
										<input type="text" name="name" lay-verify="name"
											autocomplete="off" class="layui-input"
											value="${nowUser.name }">
									</div>
								</div>


								<div class="layui-form-item">
									<label class="layui-form-label">学校</label>
									<div class="layui-input-block">
										<select id="schoolId" name="schoolId"
												lay-filter="schoolFilter0">
										</select>
									</div>
								</div>

								<div class="layui-form-item" pane="">
									<label class="layui-form-label">性别</label>
									<div class="layui-input-block">
										<input type="radio" name="sex" value="0" title="男"
											<c:if test="${nowUser.sex==0 }">checked=""</c:if>> <input
											type="radio" name="sex" value="1" title="女"
											<c:if test="${nowUser.sex!=0 }">checked=""</c:if>>
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
					alert("${msg }");
					window.location.href="common/logout.do"; 
				</script>
			</c:if>
			<c:if test="${empty flag }">
				<script type="text/javascript">
					alert("${msg }");
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
				studentId : function(value) {
					if (value.length < 5) {
						return '学号至少得5个字符啊';
					}
				},
				name : function(value) {
					if (value.length < 1) {
						return '姓名至少得1个字符啊';
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
	<script type="text/javascript">
	var form;
	layui.use([ 'layedit', 'form' ], function() {
		form = layui.form;
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
						$("#schoolId").append(optionStr);
						$("#schoolId").val(${nowUser.schoolId});
						form.render('select', 'formFilter');
					}
				}
			);
		});

	});
</script>
</body>
</html>
