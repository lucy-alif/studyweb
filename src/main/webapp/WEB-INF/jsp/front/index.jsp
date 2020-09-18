<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fm" %>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

		<title></title>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryjson.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/daydayup.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginregister.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
		<script>
			$(function() {
				$("#menu a").each(function(index, ele) {
					$(ele).bind("mouseover", function() {
						$("#menu a[class='menu-item']").removeClass(); //已经有menu-item的移除
						$(ele).toggleClass("menu-item");
					});
				});
			});
		</script>
		<script>
				$().ready(function(){
					$(".questinTitle") //提问按钮
							.bind("click",
 									function() {
										if(ifAlreadyLogin()){//登陆过
											var id=$(this).attr("id");
											location.assign("${pageContext.request.contextPath}/question/showquestion?id="+id);
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
	</head>

	<body>

		<%@include file="questionhead.jsp" %>

	

		<div style="display:none">

			<form id="returnconditions" method="post">
				<input type="hidden" name="typeId" value="1"><br>
				<input type="hidden" name="questionStartIndex" value="0"><br>
				<input type="hidden" name="orderType" value=""><br>
				<input type="hidden" name="queryQuestionTitle" value="">
				<input type="hidden" name="tagName" value="">
			</form>
		</div>
		<section id="main">
			<section id="content">
				<div id="headlist">
					<div id="menu">

						<a href="javascript:void(0)" class="menu-item">
							技术问答
						</a>

						<a href="javascript:void(0)">
							面试题
						</a>

						<a href="javascript:void(0)">
							作业问答
						</a>

					</div>
					<div style="display:none">

						<form id="orderconditions" method="post">
							<input type="text" name="typeId" value="1"><br>
							<input type="text" name="questionStartIndex" value="0"><br>
							<input type="text" name="orderType"><br>
						</form>
					</div>
					<div id="order">
						<span>排列:</span>
						<a href="javascript:void(0)" id="byDate">

							<b>最新提问</b>

						</a>
						<a href="javascript:void(0)" id="byAnswerCount">

							尚未回答

						</a>
						<a href="javascript:void(0)" id="byViewCount">

							热门

						</a>
					</div>

				</div>
		<c:forEach items="${requestScope.qList }" var="question">	
			<section class="box">
					<div class="box-f1">
						<ul>
							<li>
								${question.questionVotenum }
								<span>投票</span>
							</li>
							<li style="border:1px solid #4eaa4c; color: #4eaa4c;">
								${question.questionAnswernum}
								<span>回答</span>
							</li>
							<li>
								${question.questionViewnum }
								<span>浏览</span>
							</li>
						</ul>
					</div>
					<div class="box-f2">
						<div class="question_title">
							<a class="questinTitle" href="javascript:void(0)" id="${question.questionId}">${question.questionTitle }</a>
						</div>
						<div class="question_time">
								<span>
									发布人:
									<c:forEach items="${requestScope.userList }" var="user">
										<c:if test="${user.userId eq question.questionUserid }">${user.userName}</c:if>
									</c:forEach>
									@ 
									<fm:formatDate value="${question.questionCreatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>								
								</span>
							<span class="tag">others</span>
						</div>
					</div>
					<div class="box-f3">
						<img src="${pageContext.request.contextPath}/img/header3.jpeg">
					</div>
				</section>
		</c:forEach>
		
		<div style="float:right">
				<form action="${pageContext.request.contextPath }/question/showAll" method="post" id="pageform">
						<%@include file="/WEB-INF/jsp/page/pagingToolBarDoPost.jsp" %>
				</form>
			</div>
		</section>

			<%@include file="aside.jsp" %>
			
		</section>
		
		<%@include file="loginregister.jsp" %>
		
		

	</body>

</html>