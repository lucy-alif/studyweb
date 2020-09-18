<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
  <head>
	<meta charset="utf-8">
    <title>投票统计</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/goodstudy.css">
	<script src="http://cdn.staticfile.org/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer.js"></script>
	
 </head>
 <div>
		<%@include file="common.jsp" %>
		<div id="maincontent">
			<div id="container">
				<div class="crumb">
					<span class="breadcrumb">
					  <a href="javascript:void(0);">后台</a>&gt;
					  <a href="javascript:void(0);">数据统计</a>&gt;
					  <a href="javascript:void(0);">投票统计</a>
					</span>
				</div>
				<div id="tabledata">
					   <div id="main" style="width: 600px;height:400px;"></div>
   
    <script type="text/javascript">    
	    $().ready(function(){
	    	$.ajax({
				url:"${pageContext.request.contextPath}/vote/showVote",
				type:"post",
				dataType:"json",
				success:function(data){
					var myChart = echarts.init(document.getElementById('main'));
					myChart.setOption(data);//设置显示数据
				}   				
			})
	    })
 
        // 指定图表的配置项和数据
        /* var option = {
            series: {
                type: 'sunburst',
                data: [
		                     {
		                    	name: 'A',
		                   		value: 10,
		                    	children: [{value: 3,name: 'Aa'}, {value: 5,name: 'Ab'}]}, 
		                    {
		                    	name: 'B',
		                    	children: [{name: 'Ba',value: 4}, {name: 'Bb',value: 2}]}, 
		                    {
		                    	name: 'C',
		                    	value: 3
		                	}
                     ]
            	}
        }; */

 
    </script>
				
			</div>
				<div class="rightmsg">
					${requestScope.msg}
				</div>
				<div class="errormsg">					
				</div>
			</div>
			
		</div>
	</div>
	 
  </body>
</html>