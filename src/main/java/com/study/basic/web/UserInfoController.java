package com.study.basic.web;

 
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.study.basic.pojo.Cls;
import com.study.basic.pojo.UserInfo;
import com.study.basic.service.IBasicService;
import com.study.common.util.MD5;

@Controller
@RequestMapping("/basic")
public class UserInfoController {
	@Autowired
	private IBasicService basicService;
	
	@RequestMapping(path="/usermain",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView showAllUserinfo() {
		
		List<UserInfo> userinfo=basicService.listAllUserInfo();
		List<Cls> cList=basicService.listAllCls();
		ModelAndView mView=new ModelAndView();
		if (userinfo.size()>0) {
			mView.addObject("userinfo",userinfo);
		}else {
			mView.addObject("msg","当前无用户信息");
		}
		mView.addObject("cList",cList);
		mView.setViewName("back/userinfo");
		return mView;
		
	}
	
	@RequestMapping(path="/headmodify/{id}",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView changeUserHead(@PathVariable("id") Integer id) {
		ModelAndView mView=new ModelAndView();
		
		UserInfo userInfo=basicService.selectUserById(id);
		mView.addObject("userInfo",userInfo);
		mView.setViewName("back/headedit");
		return mView;
		
	}
	
	@RequestMapping(path="/saveuserhead/{id}/{head}",method={RequestMethod.GET,RequestMethod.POST})
	public  ModelAndView saveUserHead(@PathVariable("id") Integer id,@PathVariable("head") String headName) {		
		ModelAndView mView=new ModelAndView();
		UserInfo userInfo=basicService.selectUserById(id);
		userInfo.setUserHead(headName);
		basicService.deleteUser(userInfo);
		mView.setViewName("back/userinfo");
		return mView;
		
	}
	
	@RequestMapping(path="/userdel",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean deleteUserinfo(@RequestBody UserInfo userInfo) {
		SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.US);
		Date date=null;
		try {
			date=sdf.parse(userInfo.getUserModified().toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		userInfo.setUserModified(date);
		boolean result=basicService.deleteUser(userInfo);
		System.out.println(userInfo);
		return result;
		
	}
	
	
	@RequestMapping(path="/selectUserForEdit",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody UserInfo selectUserForEdit(Integer id) {
		UserInfo userInfo=basicService.selectUserById(id);
		
		
		return userInfo;
		
	}
	
	@RequestMapping(path="/usersave",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean saveUser(Integer userId,String userName,String userLogin,String userPasswd,String userTelephone,String userAdditional,Integer cls,@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss") Date userModified) {		
		Cls newCls=basicService.queryClsById(cls);
		UserInfo userInfo=new UserInfo();
		userInfo.setUserId(userId);
		userInfo.setUserName(userName);
		userInfo.setUserLogin(userLogin);
		userInfo.setUserPasswd(userPasswd);
		userInfo.setUserTelephone(userTelephone);
		userInfo.setUserAdditional(userAdditional);
		userInfo.setCls(newCls);
		
		boolean result=false;
		if (userId!=null) {//修改
			userInfo.setUserModified(userModified);
			userInfo.setUserModified(new Timestamp(userInfo.getUserModified().getTime()));
			result=basicService.deleteUser(userInfo);
		}else {//新增
			result=basicService.addUser(userInfo);		
		}
		return result;
		
	}
	
	
	@RequestMapping(path="/frontLogin",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody UserInfo frontLoginRequest( UserInfo userInfo ,HttpSession session) throws Exception{
		 
		userInfo=basicService.userInfoLogin(userInfo);
		
		session.setAttribute("userInfo", userInfo);
		String sessionId=session.getId();
		session.setAttribute("token", UUID.randomUUID().toString());
		session.setAttribute("sessionId", sessionId);
		
		return userInfo;
		
	}	
	
	@RequestMapping(path="/verifyoldpwd",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean verifyoldpwd(String oldPwd ,HttpSession session) throws Exception{
		UserInfo userInfo=(UserInfo)(session.getAttribute("userInfo"));
		userInfo.setUserPasswd(oldPwd);
		userInfo=basicService.userInfoLogin(userInfo);
		return userInfo!=null;
		
	}
	
	@RequestMapping(path="/islogin",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean isLogin(@RequestParam String JSESSIONID,HttpSession session) {
		boolean isLogin=false;
		
		if (JSESSIONID!=null&&JSESSIONID.equals(session.getAttribute("sessionId"))) {
			isLogin=true;
		}
		
		return isLogin;	
	}
	
	@RequestMapping(path="/changepwd",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean changepwd(String oldPwd,String newPwd,HttpSession session) throws Exception{
		UserInfo userInfo=(UserInfo)(session.getAttribute("userInfo"));
		userInfo.setUserPasswd(oldPwd);
		userInfo=basicService.userInfoLogin(userInfo);
		boolean result=false;
		if (userInfo!=null) {
			userInfo.setUserPasswd(MD5.enctypeMD5("haha"+newPwd));
			result=basicService.deleteUser(userInfo);
		}
		return result ;
		
	}
	
	
	@RequestMapping(path="/quit",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView quit(HttpSession session) throws Exception{
		ModelAndView mv=new ModelAndView();
		session.removeAttribute("userinfo");
		session.removeAttribute("token");
		session.removeAttribute("sessionId");
		session.invalidate();
		
		mv.setViewName("forward:/question/showAll");
		return mv ;
		
	}

}
