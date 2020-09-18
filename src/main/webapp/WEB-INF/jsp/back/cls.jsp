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
	<script>
		$().ready(function(){	
			//删除按钮
			$(".del").on("click",function(){
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				//var id=$(this).parent().parent().find($("input[class='clsroomId']")).val();
				var status=$(this).html()=="删除"?0:1;//根据按钮值获取本次操作要修改成何种状态
				var jsonObj={"clsId":id,"clsStatus":status}
				$.ajax({
					url:"${pageContext.request.contextPath}/basic/clsdel",
					data:JSON.stringify(jsonObj),
					type:"post",
					dataType:"json",
					contentType:"application/json;charset=utf-8",
					async:true,
					success:function(data){
						if(data==true){
							 
							if(status==1){//数据库教室状态设置为1
								$(tr).find("td").eq(5).html("有效");
								$(tr).find("td").eq(7).find("a").html("删除");
							}else{
								$(tr).find("td").eq(5).html("无效");
								$(tr).find("td").eq(7).find("a").html("恢复");
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
					  <a href="javascript:void(0);">基础管理</a>&gt;
					  <a href="javascript:void(0);">班级管理</a>
					</span>
					<span class="operatebar">
					<c:if test="${fn:contains(sessionScope.rightList,'班级新增') }">
						<input type="button" class="btn normal" value="新增" id="add"/>
					</c:if>
						
					</span>
					<script type="text/javascript">
							$().ready(function(){
								//新增按钮
								$("#add").on("click",function(){
									layer.open({
										type:1,
										title:"新增班级",
										content:$("#savediv"),//弹出层id
										closeBtn:2,
										success:function(layero,index){//弹出层回调函数
											$(layero).find("input[name='clsId']").val("");
											$(layero).find("input[name='clsName']").val("");
										}
									})	
								})
							})
					</script>
				</div>
				<div id="tabledata">
				<c:if test="${fn:contains(sessionScope .rightList.toString(),'班级查看') }">
							<table class="table">
						<tr>
							<th>班级序号</th>
							<th>班级名称</th>
							<th>教师</th>
							<th>管理员</th>
							<th>教室</th>
							<th>班级状态</th>
							
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'班级修改') }">
									<th>修改操作</th>
							</c:if>
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'班级删除') }">
									<th>删除操作</th>
							</c:if>
							
						</tr>
						<c:forEach items="${requestScope.cls}"  var="cl" varStatus="status">
							<tr id="${cl.clsId}">
								<input type="hidden" class="clId" value="${cl.clsId}"/>
								<td>${status.count}</td>
								<td class="clsName">${cl.clsName }</td>
								
								<c:forEach items="${requestScope.teachers}" var="teacher">
									<c:if test="${cl.teacherId eq teacher.teacherId}">					
										<td class="teacherId" id="${cl.teacherId }">
											${teacher.teacherNickname}
										</td>
									</c:if>	
								</c:forEach>
								<c:forEach items="${requestScope.teachers}" var="manager">
									<c:if test="${cl.managerId eq manager.teacherId}">					
										<td class="managerId" id="${cl.managerId }">
											${manager.teacherNickname}
										</td>
									</c:if>	
								</c:forEach>
								<c:forEach items="${requestScope.clsRooms}" var="clsRoom">
									<c:if test="${cl.clsroomId eq clsRoom.clsroomId}">					
										<td class="clsroomId" id="${cl.clsroomId }">
											${clsRoom.clsroomName}
										</td>
									</c:if>	
								</c:forEach>
								<td class="clsStatus">
									<c:if test="${cl.clsStatus  eq 1}">有效</c:if>
									<c:if test="${cl.clsStatus  eq 0}">无效</c:if>
								</td>
										
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'班级修改') }">
									<td><a class="modify" href="javascript:void(0);">修改</a></td>
								</c:if>
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'班级删除') }">
										<td>
									<c:if test="${cl.clsStatus  eq 1}">
										<a class="del" href="javascript:void(0);">删除</a>
									</c:if>
									<c:if test="${cl.clsStatus  eq 0}">
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
    	<!--弹出层开始  -->
    		<div id="savediv" style="display: none">
    			<div class="operatewin">
    				<form   id="modifyForm" class="editform">
    				<input type="hidden" class="txt"  name="clsId"/>
    <!--==================这是一行开始================  -->				
    					<div class="form-item">
    						<div class="form-label">
    							<label>班级名称</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="clsName"/>
    						</div>
    					</div>
  <!--==================这是一行结束================   -->					
  						<div class="form-item">
    						<div class="form-label">
    							<label>教师</label>
    						</div>
    						<div class="input-inline">
    							<select name="teacherId">
    								<c:forEach items="${requestScope.teachers}" var="teacher">
    									<option id="tech${teacher.teacherId }" value="${teacher.teacherId }">${teacher.teacherNickname}</option>
    								</c:forEach>
    							</select>
    						</div>
    					</div>
    					
    					<div class="form-item">
    						<div class="form-label">
    							<label>管理</label>
    						</div>
    						<div class="input-inline">
    							<select name="managerId">
    								<c:forEach items="${requestScope.teachers}" var="manager">
    									<option id="mana${manager.teacherId }" value="${manager.teacherId }">${manager.teacherNickname}</option>
    								</c:forEach>
    							</select>
    						</div>
    					</div>
  					
  					
  					<div class="form-item">
    						<div class="form-label">
    							<label>教室</label>
    						</div>
    						<div class="input-inline">
    							<select name="clsroomId">
    								<c:forEach items="${requestScope.clsRooms}" var="clsRoom">
    									<option id="clsr${clsRoom.clsroomId }" value="${clsRoom.clsroomId }">${clsRoom.clsroomName}</option>
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
  				 url:"${pageContext.request.contextPath}/basic/clssave",
  				 data:$("#modifyForm").serialize(),
  				 type:"post",
  				 dataType:"json",
  				 success:function(data){
  					 if(data==true){	 
  						location.replace("${pageContext.request.contextPath}/basic/clsmain");
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

