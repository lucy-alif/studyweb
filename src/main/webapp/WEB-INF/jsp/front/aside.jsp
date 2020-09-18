<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<aside>
	<h4>所有标签：</h4>
	<div class="tag">java</div>
	<div class="tag">html</div>
	<div class="tag">css</div>
	<div class="tag">jquery</div>
	<div class="tag">ajax</div>
	<div class="tag">jsp</div>
	<div class="tag">js</div>
	<div class="tag">servlet</div>
	<div class="tag">spring</div>
	<div class="tag">mybatis</div>
	<div class="tag">mysql</div>
	<div class="tag">others</div>
	<div style="display: none">
		<%--下面的表单在单击查询时提交--%>
		<form id="tagcondition" method="post"
			action="${pageContext.request.contextPath}/question/questionlist">
			<input type="text" name="typeId" value="${requestScope.typeId}" /><br />
			<input type="text" name="tagName" />
		</form>
		<script>
			$().ready(
					function() {
						$(".tag").bind(
								"click",
								function() {
									$("#tagcondition input[name='tagName']")
											.val($(this).html());
									$("#tagcondition").submit();
								});
					});
		</script>
	</div>
</aside>