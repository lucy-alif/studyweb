<%@page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://localhost/pagetools" prefix="web"%>
<script>
		function changeQuery(startIndex) {	
			var formObj = document.getElementById("pageform");		
			//将下一页面第1条记录的起始位置赋值给隐藏域,后续提交给服务器
			document.getElementById("beginIndex").value = startIndex;
			formObj.submit();
		}
</script>
<style>
.page {
	display: inline-block;
	vertical-align: middle;
	margin: 5px 0;
	background-color: #fff;
	font-size:12px;
}
.page a {
	text-decoration: none
}
.page a,.page span {
	display: inline-block;
	vertical-align: middle;
	padding: 0 15px;
	border: 1px solid #e2e2e2;
	height: 28px;
	line-height: 28px;
	margin: 0 -1px -1px 0;
	color: #333;
	font-size: 12px;
}
.page span {
	color: #999;
	font-weight: 700
}
.page .page-curr {
	position: relative;
}
.page .page-curr em {
	position: relative;
	color: #fff;
	font-weight: 400
}
.page em{
	font-style: normal
}
.page .page-curr .page-em {
	position: absolute;
	left: -1px;
	top: -1px;
	padding: 1px;
	width: 100%;
	height: 100%;
	background-color: #009688
}

.page-em {
	border-radius: 2px
}

</style>
<c:if test="${pageInfo != null}">
<!-- 进入页面时,此隐藏域保存的是当前页的起始位置,提交页面时, 此隐藏域保存的是下一页数据的起始位置-->
<input type="hidden" id="beginIndex" name="startIndex" value="${pageInfo.startIndex}"/>
<div class="page">
		<!-- 判断本页的起始位置如果为0,，即为第1页,直接显示上一页 -->
		<c:if test="${pageInfo.startIndex == 0}">
			<a href="javascript:void(0)">上一页</a>
		</c:if>
		<!-- 判断本页的起始位置如果大于0,，即不为第1页,显示可以单击上一页 -->
		<c:if test="${pageInfo.startIndex > 0}">
			<a href="javascript:void(0)" onclick="javascript:changeQuery(${pageInfo.previousIndex});">上一页</a>
		</c:if>
		<!-- 计算本次显示页码的起始位置,例如：1-5;6-9 -->
		<c:set var="beginPage" value="${web:calculatePagePeriod(pageInfo.currentPage,6)}"/>
		<c:set var="beginIndex" value="${(beginPage-1)*6+1}"/>
		<c:set var="endIndex" value="${beginPage*6}"/>
		<!-- 是否在结尾输出... -->
		<c:set var="outputTail" value="true"/>
		<!-- 判断是否超出最大页码 -->
		<c:if test="${endIndex gt pageInfo.pageCount }"> 
			<c:set var="endIndex" value="${pageInfo.pageCount}"/>
			<c:set var="outputTail" value="false"/>
		</c:if>
		<!-- beginPage:<c:out value="${beginPage }"/> -->
		<!-- beginIndex:<c:out value="${beginIndex }"/> -->
		<!-- endIndex:<c:out value="${endIndex }"/> -->
		<!-- 输出前面的... -->
		<c:if test="${beginPage gt 1}"> 
			...
		</c:if>
		<c:forEach begin="${beginIndex}" var="pageNo" step="1" end="${endIndex}">
				<c:if test="${pageInfo.currentPage eq pageNo}">
					<span class="page-curr" >
						<em class="page-em" style="background-color:#1E9FFF;"></em>
						<em>${pageNo }</em>
					</span>
				</c:if>
				<c:if test="${pageInfo.currentPage ne pageNo}">
					<a href="javascript:void(0)" 
					   onclick="javascript:changeQuery(${(pageNo-1)*pageInfo.pageSize});">
						${pageNo }
					</a>
				</c:if>
		</c:forEach>
		<!-- 输出后面的... -->
		<c:if test="${outputTail}">
			...
		</c:if>
		<!-- 判断本页的起始位置如果为最后一页,直接显示下一页 -->
		<c:if test="${pageInfo.lastPage}">
			<a href="javascript:void(0)">下一页</a>				
		</c:if>
		<!-- 判断本页的起始位置如果不为最后一页,显示可以单击下一页 -->
		<c:if test="${!pageInfo.lastPage}">
			<a href="javascript:void(0)" onclick="javascript:changeQuery(${pageInfo.nextIndex});">下一页</a>
		</c:if>
</div>
</c:if>