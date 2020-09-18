<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 页首,其它页面通过include将其包含 -->
<%@include file="top.jsp" %>
<section id="title">
	<div id="titlebar">
		<div id="leftquestion">
			<a href="javascript:void(0)" id="askquestion">我要提问</a>
			<script>
				$().ready(function(){
					$("#askquestion")
							.bind("click",
 									function() {
										if(ifAlreadyLogin()){//登陆过
											location.assign("${pageContext.request.contextPath }/question/putquestion");
										}else{//没登录过
											//$("#loglink").click();//弹出登录层
											layer.msg("执行此操作需要登录",{
												icon : -1,
												time : 2000//2秒关闭（如果不配置，默认是3秒）
											});
										}
 									}
							);
					}
				);
			</script>
		</div>
		
		<div id="rightquestion">
			<input type="text" placeholder="请输入问题标题进行查询" /> 
			<a href="javascript:void(0)"><img src="${pageContext.request.contextPath }/img/ic_search.svg" /></a>
		</div>
		<div style="display:none">
			<%--下面的表单在单击查询时提交--%>
			<form id="querycondition" method="post">
				<input type="text" name="typeId" value="${requestScope.typeId}"/><br/>
				<input type="text" name="queryQuestionTitle"/>
			</form>
			<script>
				$().ready(function(){
					$("#rightquestion a").bind("click",function(){
						$("#querycondition input[name='queryQuestionTitle']").val($("#rightquestion input").val());
						var f=$("#querycondition");
						f.prop("action","${pageContext.request.contextPath}/question/questionlist");
						if(validateQueryForm()){
							f.submit();
						}
					});
				});
				function validateQueryForm(){//验证查询条件
					var condition=$("#querycondition input[name='queryQuestionTitle']").val();
					//console.log(title);
					if(condition==""){
						layer.msg("查询条件不能为空",{
							icon : -1,
							time : 1500
						});
						return false;
					}else if($.trim(condition).length>30){
						layer.msg("查询条件不能大于30个字符",{
							icon : -1,
							time : 1500
						});
						return false;
					}
					return true;
				}
			</script>
		</div>
	</div>
</section>
