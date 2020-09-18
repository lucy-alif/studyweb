<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>后台管理登录页面</title>
<script>
	window.onload=function(){
		var f=document.getElementById("f1");
		f.onsubmit=validateForm;
	}
	function validateForm(){
		//1.取出用户名和密码
		var account=document.getElementById("txtAccount").value;
		var pwd=document.getElementById("txtPwd").value;
		//2.定义验证的正则表达式
		var reg=/.{1,8}/;
		//3.使用正则对数据进行验证
		if(!reg.test(account)||!reg.test(pwd)){//验证失败
			document.getElementById("info").innerHTML="<font color='red' size='2'>数据不完整,请重试！</font>";
			return false;
		}else{//成功
			return true;
		}	
	}
</script>
</head>
<body>
	<table align="center" width="645px" border="0">
    	<tr>
        	<td height="60px"></td>
        </tr>
    	<tr>
        	<td background="${pageContext.request.contextPath}/img/loginbackground.png" width="345px" height="346px">
            	<table border="0" width="100%" height="100%">
                	<tr>
                    	<td width="300px"></td>
                        <td width="345px">
                        	<form action="${pageContext.request.contextPath}/user/login" method="post" id="f1">
                            	<table width="70%" height="30%" border="0">
                                	<tr><td colspan="2" height="30px" style="font-family:'楷体_GB2312';font-size:20px; font-weight:bold;">欢迎进入后台管理系统</td>
                                    </tr>
                                    <tr>
                                    	<td style="font-size:12px">用户名:</td>
                                        <td>
                                        	<input type="text" name="teacherName" id="txtAccount"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td style="font-size:12px">密码:</td>
                                        <td>
                                        	<input type="password" name="teacherPwd" id="txtPwd"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td colspan="2" align="center">
                                        	<input type="image" src="${pageContext.request.contextPath}/img/b_login.gif"/>
                                        	<img src="${pageContext.request.contextPath}/img/b_clean.gif"/>
                                        	<div style="color:red">${requestScope.msg }</div>
                                        </td>
                                    </tr>
                                    <tr>
                                    	<td colspan="2" id="info">
                                        	<font color="red" size="2">
                                        		
                                        	</font>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>

