<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script language="javascript">
	$(
		function(){
			//$("li").find("ul").prev(): 有 子节点 ul的 li的前一个节点,ul前的超链接 
			$("li").find("ul").prev().click(
				function(){
					//$(this).next()://嵌套的 ul
					//toggleClass("hide"),切换样式 
					$("[class='secondMenu display']").not($(this).next()).toggleClass("display");//隐藏之前展开的
					$(this).next().toggleClass("display");//展开本次单击的
				}
			);
		}
	);
</script>
<!--头部-->
<div id="mainheader" style="color:white">
	<div style="position: absolute;right: 30px;top: 40px">
		管理员 :${sessionScope.teacher.teacherNickname }
	</div>
	
</div>

<!--菜单  -->
<div id="mainaside">
	<ul id="listUL">
		<!-- <li class="firstMenu"><a href="#">问答管理</a>
			<ul class="secondMenu">
				<li><a href="#">问题管理</a></li>
			</ul>
		</li> -->
		<li class="firstMenu"><a href="#">后台权限</a>
			<ul class="secondMenu">
				<li><a href="${pageContext.request.contextPath }/user/teachermain">员工管理</a></li>
				<li><a href="${pageContext.request.contextPath }/user/rolemain">角色管理</a></li>
				                              
			</ul>
		</li>
		<li class="firstMenu"><a href="#">基础资料</a>
			<ul class="secondMenu">
				<li><a href="${pageContext.request.contextPath }/basic/usermain">用户管理</a></li>
				<li><a href="${pageContext.request.contextPath }/basic/clsRoommain">教室管理</a></li>
				<li><a href="${pageContext.request.contextPath }/basic/clsmain">班级管理</a></li>
				
			</ul>
		</li>
		<li class="firstMenu"><a href="#">数据统计</a>
			<ul class="secondMenu">
				<li><a href="${pageContext.request.contextPath }/vote/votemain">投票统计</a></li>
				<!-- <li><a href="#">积分统计</a></li> -->
			</ul>
		</li>
	</ul>
</div>
