<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!-- 登录、注册页面,其它页面通过include将其包含 -->
<!--登录div开始-->
<div class="loginregister" id="login">
	<div>
		<form id="loginform">
			<div class="input_box">
				<input type="text" name="userLogin" id="uname" maxlength="16"
					class="input_cont" placeholder="请输入用户名" />
			</div>
			<div class="input_password">
				<input type="password" name="userPasswd" id="upass" maxlength="10"
					class="input_cont" placeholder="请输入密码 " />
			</div>
			<div class="input_checkbox">
				<input type="checkbox" style="display: none" id="remember" name="rememberPwd"/><label
					class="checkbox" for="remember">记住密码</label>
			</div>
			<div class="btn">
				<input type="button" id="logbtn" class="btn" value="登录" />
			</div>
		</form>
	</div>
</div>
<script>
	function validateLoginName() {//验证用户名
		var reg = /^[\u4e00-\u9fa5_a-zA-Z0-9]{2,16}$/;
		var dv = $("#loginform").find(".input_box");
		if (validateData(reg, "#uname")) {
			dv.css("border", "2px solid #00ff00");
			return true;
		} else {
			dv.css("border", "2px solid #ff0000");
			return false;
		}
	}
	function validateLoginPasswd() {//验证密码
		var reg = /^[_a-zA-Z0-9]{6,10}$/;
		var dv = $("#loginform").find(".input_password");
		if (validateData(reg, "#upass")) {
			dv.css("border", "2px solid #00ff00");
			return true;
		} else {
			dv.css("border", "2px solid #ff0000");
			return false;
		}
	}
	$(function() {
		if($("#loglink")){//假如页面存在id为loglink的元素
			$("#loglink").bind(
					"click",
					function() {//登录超链接单击事件
						layer.open({
							type : 1,
							title : '登录',
							//skin: 'layui-layer-rim', //加上边框
							area : [ '398px', '345px' ], //宽高:398,222;
							//content: $('#sublayer'),//content: $('#sublayer').html()会丢失事件
							resize : false,
							content : $("#login"),
							closeBtn : 1,
							success : function(layero, index) {//弹出层显示后的回调方法
								//恢复界面初始状态
								$(layero).find("input[class^='input']").parent().css("border", "1px solid #d7d7d7");//设置div边框颜色
								$(layero).find("input[class^='input']").val("");
							}
						});
					});
		}
		
		$("#loginform").find("input[name='userName']").bind("blur",validateLoginName);//密码文本框失去焦点事件
		$("#loginform").find("input[name='userPasswd']").bind("blur",validateLoginPasswd);
		$("#logbtn").bind(
						"click",
						function() {//登录按钮单击事件
							if (validateLoginName() & validateLoginPasswd()) {
								var postData = $("#loginform").serialize();
								$.ajax({
											url : "${pageContext.request.contextPath }/basic/frontLogin",
											type : "post",//请求方式
											data : postData,
											//contentType : "application/json;charset=utf-8",
											dataType : "json",//设置返回数据的类型,json,text
											beforeSend : function() {//发送前调用
											},
										 	success : function(data) {//成功回调函数	
												console.log(data);
												if (data.userId != -1) {
													layer.closeAll();
													layer.msg("登录成功", {
														icon : -1,
														time : 2000
													//2秒关闭（如果不配置，默认是3秒）
													});
													$(".log:eq(1)").show();//显示欢迎和退出
													$("#welcomelink").html($("#welcomelink").html()+data.userName);
													$(".log:eq(0)").hide();//登录和注册隐藏
													//重新绑定退出事件
												} else {
													layer.msg("用户名或密码错误,登录失败",
													{
														icon : -1,
														time : 2000
														//2秒关闭（如果不配置，默认是3秒）
													});
												}
											},
											error : function() {//错误回调函数,服务器未返回任何数据也会进入此回调
												layer.msg("请求失败,请稍后重试", {
													icon : -1,
													time : 2000
												//2秒关闭（如果不配置，默认是3秒）
												});
											},
											complete : function() {//响应结束调用

											}
										});
							}
						}
		);
		

	});
</script>
<!--登录div结束-->


<!--修改密码div开始-->
<div class="loginregister" id="changepwd">
	<div>
		<form id="changepwdform">
			<!-- 隐藏域,提交表单时,用来判断原来的密码是否正确 -->
			<input type="hidden" id="ifvalid" value=""/>
			<div class="input_password">
				<input type="password" name="oldPwd" id="opwd" maxlength="10"
					class="input_cont" placeholder="请输入旧密码" />
			</div>
			<div class="input_password">
				<input type="password" name="newPwd" id="onepwd" maxlength="10"
					class="input_cont" placeholder="请输入新密码, 字母或数字6-10位" />
			</div>
			<div class="input_password">
				<input type="password" name="confirmPwd" id="twicepwd" maxlength="10"
					class="input_cont" placeholder="请再次输入新密码 " />
			</div>
			<div class="btn">
				<input type="button" id="changepwdbtn" class="btn" value="修改密码" />
			</div>
		</form>
	</div>
</div>
<script>

	function validateTwicePwd(){
		if(validateNewPwd()){
			var twodiv = $("#changepwdform div").eq(2);
			if($("input[name='newPwd']").val()!=$("input[name='confirmPwd']").val()){
				twodiv.css("border", "2px solid #ff0000");
				return false;
			}
			twodiv.css("border", "2px solid #00ff00");
			return true;
		}
		return false;
	}
	function validateNewPwd(){
		var reg = /^[_a-zA-Z0-9]{6,10}$/;
		var onediv = $("#changepwdform div").eq(1);
		if(validateData(reg, "#onepwd")){
			onediv.css("border", "2px solid #00ff00");
			return true;
		}else{
			onediv.css("border", "2px solid #ff0000");
			return false;
		}
	}
	function validateOldPasswd() {//验证旧密码
		var reg = /^[_a-zA-Z0-9]{6,10}$/;
		var olddiv = $("#changepwdform div").eq(0);
		if(validateData(reg, "#opwd")) {//客户端校验通过
			if(ifAlreadyLogin()){//判断是否登陆过
				$.ajax({
					url:"${pageContext.request.contextPath}/basic/verifyoldpwd",
					type:"post",
					data:{
				  		"oldPwd":$("#changepwdform input[name='oldPwd']").val()
					},
					async:true,
					dataType:"json",
					success:function(data){
						if(data){
							olddiv.css("border", "2px solid #00ff00");
							$("#ifvalid").val("pass");
						}
						else{
							olddiv.css("border", "2px solid #ff0000");    
						}
					},
					error : function() {//返回null进入
						
					}
				});
				return true;
			}else{
				layer.closeAll();
				$("#loglink").click();//弹出登录层
			}
		} else {
			olddiv.css("border", "2px solid #ff0000");
			return false;
		}
	}
	$(function() {
		if($("#changepwdlink")){//假如页面存在id为loglink的元素
			$("#changepwdlink").bind(
					"click",
					function() {//登录超链接单击事件
						if(ifAlreadyLogin()){//判断是否登陆过
							layer.open({
								type : 1,
								title : '修改密码',
								//skin: 'layui-layer-rim', //加上边框
								area : [ '398px', '345px' ], //宽高:398,222;
								resize : false,
								content : $("#changepwd"),
								closeBtn : 1,
								success : function(layero, index) {//弹出层显示后的回调方法
									//恢复界面初始状态
									$(layero).find("input[class^='input']").parent().css("border", "1px solid #d7d7d7");//设置div边框颜色
									$(layero).find("input[class^='input']").val("");
								}
							});
						}else{//没登录过
							$("#loglink").click();//弹出登录层
						}
					});
		}
		
		$("#changepwdform input[name='oldPwd']").bind("blur",validateOldPasswd);//密码文本框失去焦点事件
		$("#changepwdform input[name='newPwd']").bind("blur",validateNewPwd);//密码文本框失去焦点事件
		$("#changepwdform input[name='confirmPwd']").bind("blur",validateTwicePwd);//密码文本框失去焦点事件
		
		$("#changepwdbtn").bind(
			"click",function() {//修改密码单击事件
				if(validateData(/^[_a-zA-Z0-9]{6,10}$/,"#opwd")&&$("#ifvalid").val()=="pass"){
					if(validateTwicePwd()){
						if(ifAlreadyLogin()){//判断是否登陆过
							$.ajax({
								url:"${pageContext.request.contextPath}/basic/changepwd",
								type:"post",
								data:{
							  		"oldPwd":$("#changepwdform input[name='oldPwd']").val(),
							  		"newPwd":$("#changepwdform input[name='newPwd']").val()
								},
								async:true,
								dataType:"json",
								success:function(data){
									if(data){
										layer.closeAll();
										layer.msg("密码修改成功");
										$("#loglink").click();//弹出登录层
									}
									else
										layer.msg("密码修改失败,稍后重试");
								},
								error : function() {//返回null进入
									
								}
							});
						}
					}
				}else{
					$("#changepwdform div").eq(0).css("border", "2px solid #ff0000");
				}
			}
		);
	});
</script>
<!--修改密码div结束-->