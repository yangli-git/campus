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
							<legend>院校管理</legend>
						</fieldset>
					</div>
				</div>
				
				<div class="layui-row">
					<div class="layui-col-md10">&nbsp;</div>
					<div class="layui-col-md2">
						<a onclick="addSchool()" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius">添加院校</a>
					</div>
				</div>
				
				<div class="layui-row">
					<div class="layui-col-md1">&nbsp;</div>
					<div class="layui-col-md10">
						<fieldset class="layui-elem-field">
							<legend>院校列表</legend>
							<c:forEach items="${list }" var="school">
								<div style="margin-left: 20px;margin-right: 30px;margin-top: 20px;">
								</div>
								<fieldset class="layui-elem-field layui-field-title"
									style="margin: 20px;margin-bottom: 5px;margin-top: 5px;">
									<legend><a>${school.name }</a></legend>
								</fieldset>
								<div style="margin-left: 20px;margin-right: 30px;">
									<c:if test="${school.state==0 }">
										<span class="layui-badge layui-bg-blue">正常</span>
									</c:if>
									<c:if test="${school.state!=0 }">
										<span class="layui-badge layui-bg-orange">被限制</span>
									</c:if>
									<span class="layui-badge layui-bg-gray">编号：${school.schoolId }</span>
									<span class="layui-badge layui-bg-gray">添加时间：<fmt:formatDate value="${school.addTime }" pattern=" yyyy-MM-dd HH:mm:ss" /></span>
								</div>
								<div style="margin-left: 30px;margin-right: 30px;margin-top: 10px;margin-bottom: 30px;">
									<a onclick="getSchool(${school.schoolId })" class="layui-btn layui-btn-sm layui-btn-primary layui-btn-radius">详细设置</a>
								</div>
								
							</c:forEach>
						</fieldset>

					</div>
					<div class="layui-col-md1">
						
					</div>
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
				layer.alert(JSON.stringify(data.field), {
					title : '最终的提交信息'
				})
			//return false;
			});
		});
	</script>
	<script>
		function getSchool(schoolIdStr){
			//iframe层
			layer.open({
		      type: 2,
		      title: '该学校信息',
		      shadeClose: true,
		      shade: false,
		      area: ['1000px', '600px'],
		      content: 'admin/getSchool.do?schoolIdStr='+schoolIdStr
		    });
		}
		function addSchool(){
			//iframe层
			layer.open({
		      type: 2,
		      title: '添加院校',
		      shadeClose: true,
		      shade: false,
		      area: ['1000px', '600px'],
		      content: 'adminSchoolAdd.jsp'
		    });
		}
	</script>
</body>
</html>
