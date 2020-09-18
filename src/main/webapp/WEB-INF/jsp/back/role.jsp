<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
	<meta charset="utf-8">
    <title>角色管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goodstudy.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
	<script>
		$().ready(
			function(){
				$("tr:gt(0)").on({
					"mouseover":function(){//鼠标移入事件
						$(this).css("background-color","#E0F2F9");
						$(this).css("cursor","pointer");
					},
					"mouseout":function(){//鼠标移出事件
						$(this).css("background-color","#FFFFFF");
						$(this).css("cursor","default");
					},
					"dblclick":function(){//双击事件
						var id=$(this).attr("id");/* 被双击的这一行的tr的id */
						location.replace("${pageContext.request.contextPath}/user/rolerightmodify/"+id);
					}
					 
				})
			});
	</script>
  </head>
  
  <body>
  		<div>
		<%@include file="common.jsp" %>
		<div id="maincontent">
			<div id="container">
				<div class="crumb">
					<span class="breadcrumb">
					  <a href="javascript:void(0);">后台</a>&gt;
					  <a href="javascript:void(0);">后台权限</a>&gt;
					  <a href="javascript:void(0);">角色管理</a>
					</span>
					<span class="operatebar">
						<input type="button" class="btn normal" value="新增" id="newrole"/>
					</span>
				</div>
				<div id="tabledata">
					<table class="table">
						<tr>
							<th>序号</th>
							<th>角色名称</th>
							<th>操作</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${requestScope.roles }" var="role" varStatus="status">
							<tr id="${role.roleId }">
									<td class="rolestatus">${status.count }</td>
									<td class="roleName">${role.roleName }</td>
									<td><a class="modify" href="javascript:void(0);">修改</a></td>
									<td><a class="dele" href="javascript:void(0);">删除</a></td>
							</tr>
						</c:forEach>                						 
					</table>
				</div>
				
				<script type="text/javascript">
					$().ready(function(){
						$(".modify").on("click",function(){
							//获取该行数据的id
							var tr=$(this).parent().parent();
							var id=$(tr).attr("id");//取出所在行的id属性
							$.ajax({
								url:"${pageContext.request.contextPath}/user/roleedit",
								data:"id="+id,
								type:"get",
								dataType:"json",
								success:function(data){//AJAX方法回调函数
									layer.open({
										type:1,
										title:"角色修改",
										content:$("#sublayer"),//弹出层id
										closeBtn:2,
										success:function(layero,index){//弹出层回调函数
											$(layero).find("input[name='roleId']").val(data.roleId);
											$(layero).find("input[name='roleName']").val(data.roleName);
										}
									})	
								}					
							})
						})
					})
				</script>
				<script type="text/javascript">
					$().ready(function(){
						$("#newrole").on("click",function(){
							layer.open({
								type:1,
								title:"角色新增",
								content:$("#sublayer"),//弹出层id
								closeBtn:2,
								success:function(layero,index){//弹出层回调函数
									$(layero).find("input[name='roleId']").val("");
									$(layero).find("input[name='roleName']").val("");
								}
							})	
						})
					})
				</script>
				<script type="text/javascript">
					$().ready(function(){
						$(".dele").on("click",function(){
							var id=$(this).parent().parent().attr("id");
							$.ajax({
								url:"${pageContext.request.contextPath}/user/roledelete",
								data:"rid="+id,
								type:"post",
								dataType:"json",
								success:function(data){
									if(data==true){
										$("#"+id).hide();
										layer.msg("操作成功");
									}else{
										layer.msg("操作失败");
									}
								}
							})
						})
					})
				</script>
				
				<div class="rightmsg">	
				</div>
				<div class="errormsg">
					${requestScope.msg }				
					注：双击修改角色权限
				</div>
			</div>
		</div>
	</div>
    
       	<!--弹出层开始  -->
    		<div id="sublayer">
    			<div class="operatewin">
    				<form   id="saveForm" class="editform">
    				<input type="hidden" class="txt"  name="roleId"/>
    <!--==================这是一行开始================  -->				
    					<div class="form-item">
    						<div class="form-label">
    							<label>角色名称</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="roleName"/>
    						</div>
    					</div>
  <!--==================这是一行结束================   --> 
  					
    				<div class="form-item" align="center">
    						<div class="input-inline">
    							<input type="button" class="btn"  value="保存" id="saveBtn"/>
    						</div>
    				</div>
 				</form>
    			</div>
    		</div>
    	<!--弹出层结束  -->
  </body>
  
  <script type="text/javascript">
  	$().ready(function(){
  		$("#saveBtn").on("click",function(){
  			 $.ajax({
  				 url:"${pageContext.request.contextPath}/user/saverole",
  				 data:$("#saveForm").serialize(),
  				 type:"post",
  				 dataType:"json",
  				 success:function(data){
  					 if(data!=null){
  						 var id=data.roleId;
  						 if($("#"+id).find("td[class='roleName']").html()!=null){
  							$("#"+id).find("td[class='roleName']").html(data.roleName);
  						 }else{
  							 location.replace("${pageContext.request.contextPath}/user/rolemain");							
  						 } 	  					
  	  					layer.closeAll();
  	  					layer.msg("保存成功")
  					 }else{
  						layer.msg("保存失败")
  					 }					
  				 }	 
  			 });
  		})
  	})
  </script>
</html>

