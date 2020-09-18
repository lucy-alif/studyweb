<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
	<meta charset="utf-8">
    <title>员工管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goodstudy.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
	<script>
		$().ready(function(){	
			//删除按钮
			$(".del").on("click",function(){
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				 
				var status=$(this).html()=="删除"?0:1;//根据按钮值获取本次操作要修改成何种状态
				var jsonObj={"teacherId":id,"teacherStatus":status}
				$.ajax({
					url:"${pageContext.request.contextPath}/user/teacherdel",
					data:JSON.stringify(jsonObj),
					type:"post",
					dataType:"json",
					contentType:"application/json;charset=utf-8",
					async:true,
					success:function(data){
						if(data==true){
							 
							if(status==1){
								$(tr).find("td").eq(4).html("有效");
								$(tr).find("td").eq(6).find("a").html("删除");
							}else{
								$(tr).find("td").eq(4).html("无效");
								$(tr).find("td").eq(6).find("a").html("恢复");
							}
						}else{
							layer.msg("操作失败");
						}
					},
					error:function(){
						layer.msg("操作失败");
					}
				})
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
					  <a href="javascript:void(0);">员工管理</a>
					</span>
					<span class="operatebar">
					<c:if test="${fn:contains(sessionScope.rightList,'员工新增') }">
						<input type="button" class="btn normal" value="新增" id="add"/>
					</c:if>
						
					</span>
					<script type="text/javascript">
							$().ready(function(){
								//新增按钮
								$("#add").on("click",function(){
									layer.open({
										type:1,
										title:"新增员工",
										content:$("#savediv"),//弹出层id
										closeBtn:2,
										success:function(layero,index){//弹出层回调函数
											$(layero).find("input[name='teacherId']").val("");
											$(layero).find("input[name='teacherName']").val("");
											$(layero).find("input[name='teacherNickname']").val("");
											$(layero).find("input[name='teacherPwd']").val("");
											$(layero).find("input[name='teacherPwd']").attr("readonly",false);
											
											//设置下拉框选中 
											$(layero).find("select option").eq(0).prop("selected",true);
										}
									})	
								})
							})
					</script>
				</div>
				<div id="tabledata">
				<c:if test="${fn:contains(sessionScope .rightList.toString(),'员工查看') }">
							<table class="table">
						<tr>
							<th>员工序号</th>
							<th>员工账号</th>
							<th>员工姓名</th>
							<th>员工角色</th>
							<th>员工状态</th>
							
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'员工修改') }">
									<th>修改操作</th>
							</c:if>
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'员工删除') }">
									<th>删除操作</th>
							</c:if>
							
						</tr>
						<c:forEach items="${requestScope.teachers}"  var="tech" varStatus="status">
							<tr id="${tech.teacherId}">
								<input type="hidden" class="teacherId" value="${tech.teacherId}"/>
								<td>${status.count}</td>
								<td class="teacherName">${tech.teacherName }</td>
								<td class="teacherNickname">${tech.teacherNickname }</td>
								<c:forEach items="${requestScope.roles}" var="role">
									<c:if test="${tech.roleId eq role.roleId}">					
										<td class="roleId" id="${tech.roleId}">
											${role.roleName}
										</td>
									</c:if>	
								</c:forEach>
								<td class="teacherStatus">
									<c:if test="${tech.teacherStatus  eq 1}">有效</c:if>
									<c:if test="${tech.teacherStatus  eq 0}">无效</c:if>
								</td>
										
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'员工修改') }">
									<td><a class="modify" href="javascript:void(0);">修改</a></td>
								</c:if>
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'员工删除') }">
										<td>
									<c:if test="${tech.teacherStatus  eq 1}">
										<a class="del" href="javascript:void(0);">删除</a>
									</c:if>
									<c:if test="${tech.teacherStatus  eq 0}">
										<a class="del" href="javascript:void(0);">恢复</a>
									</c:if>
									</td>
								</c:if>
								
							</tr>
						
						</c:forEach>
					</table>
				</c:if>
				</div>
							<script>
		$().ready(function(){
			//修改按钮
			$(".modify").on("click",function(){
				//获取该行数据的id
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				$.ajax({
					url:"${pageContext.request.contextPath}/user/selectTechForEdit",
					data:"id="+id,
					type:"get",
					dataType:"json",
					success:function(data){//AJAX方法回调函数
						layer.open({
							type:1,
							title:"员工修改",
							content:$("#savediv"),//弹出层id
							closeBtn:2,
							success:function(layero,index){//弹出层回调函数
								$(layero).find("input[name='teacherId']").val(data.teacherId);
								$(layero).find("input[name='teacherName']").val(data.teacherName);
								$(layero).find("input[name='teacherNickname']").val(data.teacherNickname);
								$(layero).find("input[name='teacherPwd']").val(data.teacherPwd);
								$(layero).find("input[name='teacherPwd']").attr("readonly","readonly");
								
								//设置下拉框选中 
								$(layero).find("#"+data.roleId).prop("selected",true);
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
    	<!--弹出层开始  -->
    		<div id="savediv" style="display: none">
    			<div class="operatewin">
    				<form   id="modifyForm" class="editform">
    				<input type="hidden" class="txt"  name="teacherId"/>
    <!--==================这是一行开始================  -->				
    					<div class="form-item">
    						<div class="form-label">
    							<label>员工账户</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="teacherName"/>
    						</div>
    					</div>
  <!--==================这是一行结束================   -->	
  						<div class="form-item">
    						<div class="form-label">
    							<label>员工姓名</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="teacherNickname"/>
    						</div>
    					</div>
    					<div class="form-item">
    						<div class="form-label">
    							<label>员工密码</label>
    						</div>
    						<div class="input-inline">
    							<input type="password" class="txt"  name="teacherPwd"/>
    						</div>
    					</div>			
  						<div class="form-item">
    						<div class="form-label">
    							<label>角色</label>
    						</div>
    						<div class="input-inline">
    							<select name="roleId">
    								<c:forEach items="${requestScope.roles}" var="role">
    									<option id="${role.roleId }" value="${role.roleId }">${role.roleName}</option>
    								</c:forEach>
    							</select>
    						</div>
    					</div>
    					
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
  				 url:"${pageContext.request.contextPath}/user/teachersave",
  				 data:$("#modifyForm").serialize(),
  				 type:"post",
  				 dataType:"json",
  				 success:function(data){
  					 if(data==true){	 
  						location.replace("${pageContext.request.contextPath}/user/teachermain");
  	  					layer.closeAll();
  	  					layer.msg("保存成功")
  					 }else {
  	  					layer.msg("保存失败"); 	  					
  					 } 					
  				 }				 
  			 });
  		})
  	})
  </script>
 
</html>

