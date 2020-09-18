<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title></title>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/highlight/styles/default.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/daydayup.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ask.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginregister.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />

		<body>
			<%@include file="top.jsp" %>

		

			<section id="main">
				<div id="content">
					<div class="toptitle">
						<nav class="questionnav">
							<a href="${pageContext.request.contextPath}/question/showAll">首页</a>
							&gt;
							<a href="/question/putquestion/token?typeId=1#">提问</a>
						</nav>
						<div class="return_button">
							<a href="/question/questionlist?typeId=1"><img src="${pageContext.request.contextPath}/img/return.jpg"></a>
						</div>
					</div>
					<form id="savequestion" method="post" action="${pageContext.request.contextPath}/question/savequestion">
						<!-- 表单中单个文本框按回车会提交表单,添加1个解决此问题 -->
						<input style="display:none">
						<input type="hidden" name="token" value="${sessionScope.token}">
						<div class="form-item">
							<div class="form-label">
								<label>标题:</label>
							</div>
							<div class="form-input-inline">
								<input type="text" class="ask" name="questionTitle" value="" placeholder="你有什么技术问题，请在此输入">
							</div>
						</div>
						<div class="form-item">
							<div class="form-label">
								<label>分类:</label>
							</div>
							<div class="form-input-inline">
								<span class="choice">
								<input type="radio" id="rdo1" name="questionType.questionTypeId" value="1" checked="checked">
								<label for="rdo1">技术问答</label>
						</span>
								<span class="choice">
								<input type="radio" id="rdo3" name="questionType.questionTypeId" value="2">
								<label for="rdo3">面试题</label>
						</span>
								<span class="choice">
								<input type="radio" id="rdo4" name="questionType.questionTypeId" value="3">
								<label for="rdo4">作业问答</label>
						</span>
							</div>
						</div>
						<div class="form-item">
							<div class="form-label-small">
								<label>标签:</label>
							</div>
							<div class="form-input-inline-small">
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check1" value="java">
								<label for="check1">java</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check2" value="html">
								<label for="check2">html</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check3" value="css">
								<label for="check3">css</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check4" value="jquery">
								<label for="check4">jquery</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check5" value="ajax">
								<label for="check5">ajax</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check7" value="js">
								<label for="check7">js</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check6" value="jsp">
								<label for="check6">jsp</label>
							</span>
							</div>
						</div>
						<div class="form-item">
							<div class="form-label-small">
								<label></label>
							</div>
							<div class="form-input-inline-small">
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check8" value="servlet">
								<label for="check8">servlet</label>
						</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check10" value="spring">
								<label for="check10">spring</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check12" value="mybatis">
								<label for="check12">mybatis</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check13" value="mysql">
								<label for="check13">mysql</label>
							</span>
								<span class="tagchoice">
								<input type="checkbox" name="questionTags" id="check14" value="others">
								<label for="check14">others</label>
						</span>
							</div>
						</div>
						<div style="margin-top: 50px;">
							<textarea name="questionContent" id="content" style="visibility: hidden; display: none;">
						
					</textarea>
							<script type="text/javascript">
								CKEDITOR.replace("questionContent");
							</script>
						</div>
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
								$("#savequestion").submit();//将整个表单进行提交
							});
						})
					</script>
				</div>

				<%@include file="aside.jsp" %>
			</section>

			<%@include file="loginregister.jsp" %>

		</body>

</html>