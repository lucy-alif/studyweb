<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
  <head>
	<meta charset="utf-8">
    <title>教室管理</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goodstudy.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
	<script>
		$().ready(function(){
			//修改按钮
			$("#bigTable").on("click",".modify",function(){
	//知识点：事件委托 语法$("父级元素").on("click","要绑定事件的元素或类",function(){dosomething});
				//获取该行数据的id
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				$.ajax({
					url:"${pageContext.request.contextPath}/basic/clsroomedit",
					data:"id="+id,
					type:"get",
					dataType:"json",
					success:function(data){//AJAX方法回调函数
						layer.open({
							type:1,
							title:"教室修改",
							content:$("#sublayer"),//弹出层id
							closeBtn:2,
							success:function(layero,index){//弹出层回调函数
								$(layero).find("input[name='clsroomId']").val(data.clsroomId);
								$(layero).find("input[name='clsroomName']").val(data.clsroomName);
							}
						})	
					}					
				})
			});
			//删除按钮
			$("#bigTable").on("click",".del",function(){
				var tr=$(this).parent().parent();
				var id=$(tr).attr("id");//取出所在行的id属性
				//var id=$(this).parent().parent().find($("input[class='clsroomId']")).val();
				var status=$(this).html()=="删除"?0:1;//根据按钮值获取本次操作要修改成何种状态
				var jsonObj={"clsroomId":id,"clsroomStatus":status}
				$.ajax({
					url:"${pageContext.request.contextPath}/basic/clsRoomdel",
					data:JSON.stringify(jsonObj),
					type:"post",
					dataType:"json",
					contentType:"application/json;charset=utf-8",
					async:true,
					success:function(data){
						if(data==true){
							//var statusText=$(this).parent().parent().find("td[class='clsroomStatus']");
							if(status==1){//数据库教室状态设置为1
								$(tr).find("td").eq(2).html("有效");//第三个单元格
								$(tr).find("td").eq(4).find("a").html("删除");//第五个单元格
							}else{
								$(tr).find("td").eq(2).html("无效");//第三个单元格
								$(tr).find("td").eq(4).find("a").html("恢复");//第五个单元格
							}
							//console.log(statusText);
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
					  <a href="javascript:void(0);">教室管理</a>
					</span>
					<span class="operatebar">
						<c:if test="${fn:contains(sessionScope.rightList,'教室新增') }">
							<input type="button" class="btn normal" value="新增" id="add"/>
						</c:if>
					</span>
				<script type="text/javascript">
							$().ready(function(){
								//新增按钮
								$("#add").on("click",function(){
									layer.open({
										type:1,
										title:"新增教室",
										content:$("#sublayer"),//弹出层id
										closeBtn:2,
										success:function(layero,index){//弹出层回调函数
											//把之前的数据清空
											$(layero).find("input[name='clsroomId']").val("");
											$(layero).find("input[name='clsroomName']").val("");
										}
									})	
								})
							})
				</script>
					
				</div>
				<div id="tabledata">
				<c:if test="${fn:contains(sessionScope .rightList.toString(),'教室查看') }">
					<table class="table" id="bigTable" rights="${sessionScope.rightList}">
					<script>
						console.log($("#bigTable").attr("rights"));
						console.log($("#bigTable").attr("rights").indexOf("教室查看"));//这个值大于0就说明有这个权限
					</script>
						<tr>
							<th>教室序号</th>
							<th>教室名称</th>
							<th>教室状态</th>
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'教室修改') }">
									<th>修改操作</th>
							</c:if>
							<c:if test="${fn:contains(sessionScope.rightList.toString(),'教室恢复删除') }">
									<th>删除操作</th>
							</c:if>						
						</tr>
						<c:forEach items="${requestScope.clsRooms}"  var="clsroom" varStatus="status">
							<tr id="${clsroom.clsroomId}">
								<td id="${status.count}">${status.count}</td>
								<td class="clsroomName">${clsroom.clsroomName }</td>
								<td class="clsroomStatus">
									<c:if test="${clsroom.clsroomStatus  eq 1}">有效</c:if>
									<c:if test="${clsroom.clsroomStatus  eq 0}">无效</c:if>
								</td>
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'教室修改') }">
									<td><a class="modify" href="javascript:void(0);">修改</a></td>
								</c:if>
								<c:if test="${fn:contains(sessionScope.rightList.toString(),'教室恢复删除') }">
									<td>
										<c:if test="${clsroom.clsroomStatus  eq 1}">
											<a class="del" href="javascript:void(0);">删除</a>
										</c:if>
										<c:if test="${clsroom.clsroomStatus  eq 0}">
											<a class="del" href="javascript:void(0);">恢复</a>
										</c:if>
									</td>
								</c:if>								
							</tr>					
						</c:forEach>			
					</table>
				</c:if>
				
				</div>
					<div class="rightmsg">
						${requestScope.msg}
					</div>
					<div class="errormsg">					
					</div>
			</div>
		</div>
	</div>
    	<!--弹出层开始  -->
    		<div id="sublayer">
    			<div class="operatewin">
    				<form   id="saveForm" class="editform">
    				<input type="hidden" class="txt"  name="clsroomId"/>
    <!--==================这是一行开始================  -->				
    					<div class="form-item">
    						<div class="form-label">
    							<label>教室名称</label>
    						</div>
    						<div class="input-inline">
    							<input type="text" class="txt"  name="clsroomName"/>
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
  				 url:"${pageContext.request.contextPath}/basic/clsroomsave",
  				 data:$("#saveForm").serialize(),
  				 type:"post",
  				 dataType:"json",
  				 success:function(data){
  					 if(data!=null){
  						 var id=data.clsroomId;
  						 if($("#"+id).find("td[class='clsroomName']").html()!=null){
  							 //id对应的单元格不是空，说明是修改
  							$("#"+id).find("td[class='clsroomName']").html(data.clsroomName);
  						 }else{
  							 //id对应的单元格是空的，找不到，说明是新增
  							 //准备要拼接的字符串和数据
  							var tr=$("table[class='table'] tr:last");//找到table中最后一个tr
  							var c=tr.find("td").eq(0).attr("id");//取出第一个td的id的值(此时为字符串)
  							var count= Number(c)+1;//序号
  							var status="";//状态
  							var del="";//删除
  							var modify="";//修改
  							var td3=tr.find("td").eq(3);//最后一行的修改
  							var td4=tr.find("td").eq(4);//最后一行的删除
  							/* if(data.clsroomStatus==1){
  								status="有效";
  								if(td3.find("a[class='modify']").html()!=null&&td4.find("a[class='del']").html()!=null){
  									//根据最后一行tr查看是否存在修改键和删除键，思路：对于同一张表格session中的权限是相同的
  									modify="<td><a class='modify' href='javascript:void(0);'>修改</a></td>";
  									del="<td><a class='del' href='javascript:void(0);'>删除</a></td>";
  								}
  							}else{
  								status="无效";
  								if(td3.find("a[class='modify']").html()!=null&&td4.find("a[class='del']").html()!=null){
  									modify="<td><a class='modify' href='javascript:void(0);'>修改</a></td>";
  									del="<td><a class='del' href='javascript:void(0);'>恢复</a></td>";
  								}
  							} */
  							if($("#bigTable").attr("rights").indexOf("教室修改")>0){
  								modify="<td><a class='modify' href='javascript:void(0);'>修改</a></td>";
  							}
  							
  								if(data.clsroomStatus==1){
  									status="有效";
  									if($("#bigTable").attr("rights").indexOf("教室恢复删除")>0){
  										del="<td><a class='del' href='javascript:void(0);'>删除</a></td>";
  									}
  									
  	  							}else{
  	  								status="无效";
  	  								if($("#bigTable").attr("rights").indexOf("教室恢复删除")>0){
  	  									del="<td><a class='del' href='javascript:void(0);'>恢复</a></td>";
  	  								}
  	  							}
  							
  							
 		 
  							var str="<tr id='"+data.clsroomId+"'>"+
  							"<td id='"+count+"'>"+count+"</td>"+
  							"<td class='clsroomName'>"+data.clsroomName+"</td>"+
  							"<td class='clsroomStatus'>"+status+"</td>"+	
  							modify+del+"</tr>";
							//把组装好的字符串append进table中	
  							 $("table[class='table']").append($(str));		
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

