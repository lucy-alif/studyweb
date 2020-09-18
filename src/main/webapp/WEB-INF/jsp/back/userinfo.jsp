<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
	<meta charset="utf-8">
    <title>用户管理</title>
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
						location.replace("${pageContext.request.contextPath}/basic/headmodify/"+id);
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
					  <a href="javascript:void(0);">基础管理</a>&gt;
					  <a href="javascript:void(0);">用户管理</a>
					</span>
					<span class="operatebar">
					<c:if test="${fn:contains(sessionScope.rightList,'用户新增') }">
						<input type="button" class="btn normal" value="新增" id="add"/>
					</c:if>
						
					</span>
					<script type="text/javascript">
							$().ready(function(){
								//新增按钮
								$("#add").on("click",function(){
									layer.open({
										type:1,
										title:"新增用户",
										content:$("#savediv"),//弹出层id
										closeBtn:2,
										success:function(layero,index){//弹出层回调函数
											$(layero).find("input[name='userId']").val("");
											$(layero).find("input[name='userName']").val("");
											$(layero).find("input[name='userLogin']").val("");
											$(layero).find("input[name='userPasswd']").attr("readonly",false);
											$(layero).find("input[name='userPasswd']").val("");
											$(layero).find("input[name='userTelephone']").val("");
											$(layero).find("select option").eq(0).prop("selected",true);
										}
									})	
								})
							})
					</script>
				</div>
				<div id="tabledata">
				<c:if test="${fn:contains(sessionScope .rightList.toString(),'用户查看') }">
							<table class="table">
						<tr>
							<th>用户序号</th>
							<th>用户头像</th>
							<th>用户名</th>
							<th>登录名</th>
							<th>联系方式</th>
							<th>用户状态</th>
							<th>用户班级</th>
							
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'用户修改') }">
									<th>修改操作</th>
							</c:if>
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'用户删除') }">
									<th>删除操作</th>
							</c:if>
							
						</tr>
						<c:forEach items="${requestScope.userinfo}"  var="user" varStatus="status">
							<tr id="${user.userId}">
							
								<input type="hidden" class="userModified" value="
								<fmt:formatDate value='${user.userModified }' pattern='yyyy-MM-dd HH:mm:ss'/>
								"/>
								<td>${status.count}</td>
								<td class="userHead"><img src="../img/${user.userHead}"/></td>
								
								<td class="userName">${user.userName }</td>
								<td class="userLogin">${user.userLogin }</td>
								<td class="userTelephone">${user.userTelephone }</td>
								<td class="userStatus">
									<c:if test="${user.userStatus  eq 1}">有效</c:if>
									<c:if test="${user.userStatus  eq 0}">无效</c:if>
								</td>
								<td id="${user.cls.clsId }">${user.cls.clsName }</td>
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'用户修改') }">
									<td><a class="modify" href="javascript:void(0);">修改</a></td>
								</c:if>
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'用户删除') }">
										<td>
									<c:if test="${user.userStatus  eq 1}">
										<a class="del" href="javascript:void(0);">删除</a>
									</c:if>
									<c:if test="${user.userStatus  eq 0}">
										<a class="del" href="javascript:void(0);">恢复</a>
									</c:if>
									</td>
								</c:if>
								
							</tr>
						
						</c:forEach>
					</table>
				</c:if>
				<script type="text/javascript">
					$().ready(function(){
						$(".del").on("click",function(){
							var tr=$(this).parent().parent();
							var id=tr.attr("id");
							var status=$(this).html()=="删除"?0:1;
							var modified=tr.find("input[class='userModified']").val();
							var jsonObj={"userId":id,"userStatus":status,"userModified":modified}
							$.ajax({
								url:"${pageContext.request.contextPath}/basic/userdel",
								data:JSON.stringify(jsonObj),
								type:"post",
								dataType:"json",
								contentType:"application/json;charset=utf-8",
								async:true,
								success:function(data){
									if(data==true){
										//var statusText=$(this).parent().parent().find("td[class='clsroomStatus']");
										/* if(status==1){//用户状态设置为1
											$(tr).find("td").eq(5).html("有效");//
											$(tr).find("td").eq(8).find("a").html("删除");
										}else{
											$(tr).find("td").eq(5).html("无效");
											$(tr).find("td").eq(8).find("a").html("恢复");
										} */
										location.replace("${pageContext.request.contextPath}/basic/usermain");
									}else{
										layer.msg("操作失败");
									}
								},
								error:function(){
									layer.msg("操作失败");
								}
							})
							
						})
					})
				
				</script>
				
				<script>
		$().ready(function(){
			//修改按钮
			$(".modify").on("click",function(){
				//获取该行数据的id
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				$.ajax({
					url:"${pageContext.request.contextPath}/basic/selectUserForEdit",
					data:"id="+id,
					type:"get",
					dataType:"json",
					success:function(data){//AJAX方法回调函数
						layer.open({
							type:1,
							title:"用户修改",
							content:$("#savediv"),//弹出层id
							closeBtn:2,
							success:function(layero,index){//弹出层回调函数
								$(layero).find("input[name='userId']").val(data.userId);
								$(layero).find("input[name='userName']").val(data.userName);
								$(layero).find("input[name='userLogin']").val(data.userLogin);
								$(layero).find("input[name='userPasswd']").val(data.userPasswd);
								$(layero).find("input[name='userPasswd']").attr("readonly","readonly");
								$(layero).find("input[name='userTelephone']").val(data.userTelephone);
								$(layero).find("input[name='userModified']").val(data.userModified);
								
								$(layero).find("input[name='userAdditional']").val(data.userAdditional);
								//设置班级下拉框选中 
								$(layero).find("#"+data.cls.clsId).prop("selected",true);
								
							}
						})	
					}							
				})
			});
		});
	</script>
				</div>
					<div class="rightmsg">
						${requestScope.msg}
					</div>
					<div class="errormsg">	
					<!-- 	注：双击更换用户头像 -->			
					</div>
			</div>
		</div>
	</div>
 
    	<!--弹出层开始  -->
    		<div id="savediv" style="display: none">
    			<div class="operatewin">
    				<form   id="modifyForm" class="editform">
    				<input type="hidden" class="txt"  name="userId"/>
    				<input type="hidden" class="txt"  name="userModified" />
    <!--==================这是一行开始================  -->				
    					<div class="form-item">
    						<div class="form-label">
    							<label>用户名</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="userName"/>
    						</div>
    					</div>
  <!--==================这是一行结束================   -->
  						<div class="form-item">
    						<div class="form-label">
    							<label>登录名</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="userLogin"/>
    						</div>
    					</div>
  						<div class="form-item">
    						<div class="form-label">
    							<label>登录密码</label>
    						</div>
    						<div class="input-inline">
    							<input type="password" class="txt"  name="userPasswd"/>
    						</div>
    					</div>
   						<div class="form-item">
    						<div class="form-label">
    							<label>联系方式</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="userTelephone"/>
    						</div>
    					</div>
    					<div class="form-item">
    						<div class="form-label">
    							<label>登录备注</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="userAdditional"/>
    						</div>
    					</div>
  						<div class="form-item">
    						<div class="form-label">
    							<label>用户班级</label>
    						</div>
    						<div class="input-inline">
    							<select name="cls">
    								<c:forEach items="${requestScope.cList }" var="cls">
    									<option id="${cls.clsId }" value="${cls.clsId }">${cls.clsName}</option>
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
  				 url:"${pageContext.request.contextPath}/basic/usersave",
  				 data:$("#modifyForm").serialize(),
  				 type:"post",
  				 dataType:"json",
  				 success:function(data){
  					 if(data!=null){	 
  						location.replace("${pageContext.request.contextPath}/basic/usermain");
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

