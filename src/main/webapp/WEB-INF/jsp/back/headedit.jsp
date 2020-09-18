<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
	<meta charset="utf-8">
    <title>班级管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goodstudy.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
  </head>
  
  <body>
  		<div>
		<%@include file="common.jsp" %>
		<div id="maincontent">
			<div id="container">
				<div class="crumb">
					<span class="breadcrumb">
					  <a href="javascript:void(0);">后台</a>&gt;
					  <a href="javascript:void(0);">基础管理</a>&gt;
					  <a href="javascript:void(0);">班级管理</a>
					</span>
				</div>
				<div id="tabledata">
				
					<table class="table">
						<tr>
							<td>
								<a href="${pageContext.request.contextPath}/basic/saveuserhead/${requestScope.userInfo.userId}/header1.jpg">
									<img src="${pageContext.request.contextPath}/img/header1.jpg"/>
								</a>								
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/basic/saveuserhead/${requestScope.userInfo.userId}/header2.jpg">
									<img src="${pageContext.request.contextPath}/img/header2.jpg"/>
								</a>
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/basic/saveuserhead/${requestScope.userInfo.userId}/header2.png">
									<img src="${pageContext.request.contextPath}/img/header2.png"/>
								</a>	
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/basic/saveuserhead/${requestScope.userInfo.userId}/header3.jpeg">
									<img src="${pageContext.request.contextPath}/img/header3.jpeg"/>
								</a>	
							</td>
						</tr>
					</table>
				</div>
	<script>
		$().ready(function(){
			//修改按钮
			$(".modify").on("click",function(){
				//获取该行数据的id
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				$.ajax({
					url:"${pageContext.request.contextPath}/basic/selectClsForEdit",
					data:"id="+id,
					type:"get",
					dataType:"json",
					success:function(data){//AJAX方法回调函数
						layer.open({
							type:1,
							title:"班级修改",
							content:$("#savediv"),//弹出层id
							closeBtn:2,
							success:function(layero,index){//弹出层回调函数
								$(layero).find("input[name='clsId']").val(data.clsId);
								$(layero).find("input[name='clsName']").val(data.clsName);
								//设置下拉框选中 
								$(layero).find("#tech"+data.teacherId).prop("selected",true);	
								$(layero).find("#mana"+data.managerId).prop("selected",true);	
								$(layero).find("#clsr"+data.clsroomId).prop("selected",true);	
							}
						})	
					}							
				})
			});
		});
	</script>
				<div class="rightmsg">
					${requestScope.msg}
				</div>
				<div class="errormsg">
					
				</div>
			</div>
		</div>
	</div> 	
  </body>
</html>

