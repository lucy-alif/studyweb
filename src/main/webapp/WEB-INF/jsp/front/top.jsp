<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 页首,其它页面通过include将其包含 --%>
<header>
	<div id="headerbar">
		<ul id="navigation">
			<li>
				<a href="${pageContext.request.contextPath}/question/questionlist">问答</a>
			</li>
			<li>
				<a href="javascript:void(0)">练习</a>
			</li>
			<li>
				<a href="javascript:void(0)">考试</a>
			</li>
		</ul>
		<script>
			$().ready(function(){
				$("#navigation").find("a").eq(1).on("click",function(){
					if(ifAlreadyLogin()){
						location.replace("${pageContext.request.contextPath}/exam/exerciselist");
					}else{
						layer.msg("执行此操作需要登录",{
							icon : -1,
							time : 2000//2秒关闭（如果不配置，默认是3秒）
						});
					}
				});
				$("#navigation").find("a").eq(2).on("click",function(){
					if(ifAlreadyLogin()){
						location.replace("${pageContext.request.contextPath}/exam/examlist");
					}else{
						layer.msg("执行此操作需要登录",{
							icon : -1,
							time : 2000//2秒关闭（如果不配置，默认是3秒）
						});
					}
				});
			});
		</script>
		<ul class="log"
			<c:if test="${not empty sessionScope.userInfo }"> style="display:none"</c:if>>
			<li><a href="javascript:void(0);" id="loglink">登录</a></li>			
		</ul>
		<ul class="log"
			<c:if test="${empty sessionScope.userInfo }"> style="display:none"</c:if>>
			<li><a href="javascript:void(0);" id="welcomelink">欢迎 :
					${sessionScope.userInfo.userName }</a></li>
			<li><span></span></li>
			<li>
				<a href="javascript:void(0);" id="changepwdlink">修改密码</a>
			</li>
			<li><span></span></li>
			<li><a href="javascript:void(0);" id="quitlink">退出</a></li>
		</ul>
	</div>
</header>
<script>
	$(function() {
		
		$("#quitlink").bind("click",
			function() {//退出事件
				layer.confirm(
					"确定退出?",{btn : [ "退出", "取消" ]},
					function(index) {//退出不采用ajax的方式,采用ajax会导致页面需要登录才能进行的操作报异常
						location.replace("${pageContext.request.contextPath }/basic/quit");
					}, function() {});
				});

	});
	function ifAlreadyLogin() {//发出ajax请求,判断是否登录过
		var isLogined = false;
		$.ajax({
			//ajax请求参数中需要将sessionId传递到服务器,服务器才能获得session,否则session为null
			url : "${pageContext.request.contextPath}/basic/islogin?JSESSIONID=${pageContext.session.id}",
			type : "get",//请求方式
			async : false,//同步 
			dataType : "json",//设置返回数据的类型
			success : function(data) {//成功回调函数	
				if (data) {//登录过
					isLogined = true;
				console.log(isLogined);
				}
			},
			error : function() {//错误回调函数,服务器未返回任何数据也会进入此回调
				layer.msg("请求失败,请稍后重试", {
					icon : -1,
					time : 2000
				});
		},});
		return isLogined;
	}
</script>

