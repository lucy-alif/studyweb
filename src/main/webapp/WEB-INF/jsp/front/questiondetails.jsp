<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

		<title>问题详情页面</title>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryjson.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/highlight/styles/default.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/daydayup.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginregister.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/questiondetail.css" />
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
		
	<body>

		<%@include file="questionhead.jsp" %>
		<div style="display:none">
			<form id="returnconditions" method="post">
				<input type="hidden" name="typeId" value="1"><br>
				<input type="hidden" name="startIndex" value="0"><br>
				<input type="hidden" name="orderType" value=""><br>
				<input type="hidden" name="queryQuestionTitle" value="">
				<input type="hidden" name="tagName" value="">
			</form>
		</div>
		<section id="main">
			<div id="content">
				<div class="toptitle">
					<nav class="questionnav">
						<a href="javascript:void(0)">技术问答</a>
						<div class="return_button">
							<a href="javascript:void(0)">
								<img src="${pageContext.request.contextPath}/img/return.jpg">
							</a>
						</div>
					</nav>
					<div class="total_answer">
						${requestScope.question.questionAnswernum}
						<br>
						<span>回答</span>
					</div>
					<span class="question_title_link">问题内容</span>
				</div>
				<section class="content-container">
					<section class="questioncontainer">
						<div>
							<div class="vote_collect_wrapper">
								<div class="vote_collect">
									<a class="vote_up" onclick="vote(31,'question',1)" title="顶">
									</a>
									<span id="questionVoteCount31" class="vote_count">2</span>
									<a class="vote_down" onclick="vote(31,'question',-1)" title="踩">
									</a>
								</div>
							</div>
							<div class="question-content-detail">
								<section>
									<p>
										${requestScope.question.questionTitle }
									</p>
									<div>
										<p>
											${requestScope.question.questionContent }
										</p>
									</div>
								</section>
							</div>
						</div>
						<div class="userdetail">
							<div class="userinfo">
								<span class="uname">${requestScope.whoAsk.userName}</span>
								<span class="edittime">
									<fm:formatDate value="${requestScope.question.questionCreatetime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</span>
							</div>
							<div id="bigheader">
								<img src="${pageContext.request.contextPath}/img/${requestScope.whoAsk.userHead}">
							</div>
						</div>
					</section>
					<div class="answer_content">
						<div class="answer_count">
							<span>总共有${requestScope.question.questionAnswernum}条回答</span>
							<span class="answer_order">
								<a class="selected" href="javascript:void(0)">显示最新答案</a>
								<a href="javascript:void(0)">按票数排序</a>
							</span>
						</div>
						<div style="display:none">
							<form id="answerquery" method="post" action="/question/questiondetails/31/token">
								<input type="hidden" name="typeId" value="1"><br>
								<input type="hidden" name="questionStartIndex" value="0"><br>
								<input type="hidden" name="orderType" value=""><br>
								<input type="hidden" name="queryQuestionTitle" value="">
								<input type="hidden" name="tagName" value="">
								<input type="hidden" name="answerOrderType" value=""><br>
							</form>
						</div>
						<div>
							<section class="answer_list">
								<c:forEach items="${requestScope.answerList}" var="answer">
									<article class="answer_detail">
										<div class="vote_collect_wrapper">
											<div class="vote_collect">
												<a class="vote_up" onclick="vote(82,'answer',1)" title="顶">
												</a>
												<span id="answerVoteCount82" class="vote_count">-1</span>
												<a class="vote_down" onclick="vote(82,'answer',-1)" title="踩">
												</a>
											</div>
										</div>
										<div class="answer-content-detail">
											<section>
												<div>
													<p>${answer.answerContent}</p>
												</div>
											</section>
										</div>
										<div class="userdetail">
											<c:forEach items="${requestScope.userInfos}" var="user">
												<c:if test="${answer.answerUserid eq user.userId}">
													<div class="userinfo">
														<span class="uname">${user.userName}</span>
														<span class="edittime">
															<fm:formatDate value="${answer.answerCreatetime}" pattern="yyyy-MM-dd HH:mm:ss" />
														</span>
													</div>
													<div id="smallheader">
														<img src="${pageContext.request.contextPath}/img/${user.userHead}">
													</div>
												</c:if>
											</c:forEach>
										</div>
									</article>
									</c:forEach>
									<form id="saveanswer" action="${pageContext.request.contextPath}/question/saveanswer" method="post">
										<!-- 使用隐藏域记住目前用户浏览的问题类型以及目前页数的起始位置 -->
										<input type="hidden" name="typeId" value="1"><br>
										<input type="hidden" name="questionStartIndex" value="0"><br>
										<input type="hidden" name="orderType" value=""><br>
										<input type="hidden" name="queryQuestionTitle" value="">
										<input type="hidden" name="tagName" value="">
										<input type="hidden" name="answerOrderType" value=""><br>
										<!-- 使用隐藏域记住令牌 -->
										<input type="hidden" name="token" value="${sessionScope.token}">
										<!-- 使用隐藏域记住题目的ID -->
										<input type="hidden" name="answerQuestionid" value="${requestScope.question.questionId}">
										<!-- 使用隐藏域记住提问此题目的用户ID -->
										<input type="hidden" name="userId" value="${requestScope.whoAsk.userId}">
										<textarea name="answerContent" id="content" style="visibility: hidden; display: none;"></textarea>
										<script type="text/javascript">
											CKEDITOR.replace("answerContent");
										</script>
										<div class="answersub">
											<input id="answersubbtn" type="button" value="提交回答">
										</div>
									</form>
								
									<script type="text/javascript">
										$(function(){
											$("#answersubbtn").click(function(){
											var oEditor = CKEDITOR.instances.content; //获取富文本编辑器
											var content = oEditor.getData();//获取富文本编辑器内的数据
											$("[name='questionContent']").html(content);//将富文本编辑器的内容设置到textarea中
											$("#saveanswer").submit();//将整个表单进行提交
							});
						})
					</script>
							</section>
						</div>
					</div>
				</section>
			</div>

			<%@include file="aside.jsp" %>
		</section>

		<%@include file="loginregister.jsp" %>

	</body>

</html>