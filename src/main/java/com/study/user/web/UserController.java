package com.study.user.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.study.basic.pojo.UserInfo;
import com.study.user.pojo.Role;
import com.study.user.pojo.Teacher;
import com.study.user.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private IUserService userService;
	
	@RequestMapping(path="/login",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView loginRequest( Teacher teacher,HttpSession session) throws Exception{
		ModelAndView mView=new ModelAndView();
		teacher=userService.loginByTchNameAndPwd(teacher);
		
		if (teacher!=null) {
			session.setAttribute("teacher", teacher);
			Role role=userService.queryRoleAndRightByRoleId(teacher.getRoleId());
			session.setAttribute("rightList", role.getRightList());//将用户的权限集合存入会话
			mView.addObject("teacher", teacher);
			mView.setViewName("back/main");
		}else{
			mView.addObject("msg", "用户名或密码错误");
			mView.setViewName("back/login");
		}
		
		
		return mView;
		
	}
	
	
	@RequestMapping(path="/rolemain",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView listAllRole() throws Exception{
		ModelAndView mView=new ModelAndView();
		List<Role> roles=userService.listAllRole();
		
		if (roles.size()>0) {
			mView.addObject("roles", roles);
			mView.setViewName("back/role");
		}else{
			mView.addObject("msg", "暂无数据");
			mView.setViewName("back/role");
		}
		
	
		return mView;
		
	}
	
	
	@RequestMapping(path="/rolerightmodify/{roleId}",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView rolerightModify(@PathVariable("roleId") Integer roleId) throws Exception{
		ModelAndView mView=new ModelAndView();
		Role role=userService.queryRoleAndRightByRoleId(roleId);
		System.out.println(role);
		mView.addObject("role", role);
		mView.setViewName("back/roleedit");
		return mView;
		
	}
	
	
	@RequestMapping(path="/saveright",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView saveRoleright (Integer roleId,@RequestParam(value="rights",required=false) List<Integer> rightsIdList) throws Exception{
		//@RequestParam(value="rights",required=false)如果页面没有传数据过来，那么参数为null
		
		ModelAndView mView=new ModelAndView();
		userService.modifyRoleRights(roleId, rightsIdList);
		
		mView.setViewName("forward:/user/rolemain");
		return mView;
		
	}

	
	@RequestMapping(path="/roleedit",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Role updateRole(Integer id) {
		Role role=userService.selectRoleById(id);
		
		return role;
		
	}
	
	
	@RequestMapping(path="/saverole",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Role saveRole (Role role) throws Exception{
		if (role.getRoleId()!=null&&!"".equals(role.getRoleId())) {
			role=userService.updateRole(role);
		}else{
			userService.addRole(role);			
		}
		
		
		return  role;
		
	}
	
	@RequestMapping(path="/roledelete",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean deleteRole(Integer rid) {
		boolean result=false;
		 
		result=userService.deleteRole(rid);
		 
		
		return result;
		
	}
	
	@RequestMapping(path="/teachermain",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView listAllteacher() throws Exception{
		ModelAndView mView=new ModelAndView();
		List<Teacher> teachers=userService.listAllTeacher();
		List<Role> roles=userService.listAllRole();
		if (teachers.size()>0) {
			mView.addObject("teachers", teachers);
			mView.addObject("roles", roles);
			mView.setViewName("back/teacher");
		}else{
			mView.addObject("msg", "暂无数据");
			mView.setViewName("back/teacher");
		}
		return mView;
	}
	
	@RequestMapping(path="/selectTechForEdit",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Teacher selectForteacherEdit(Integer id) {
		Teacher teacher=userService.queryTeacherById(id);
		
		return teacher;
		
	}
	
	@RequestMapping(path="/teacherdel",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean deleteTeacher(@RequestBody Teacher teacher) {
		boolean result=false;
		 
		result=userService.deleteTeacherStatus(teacher);
		 
		
		return result;
		
	}
	
	@RequestMapping(path="/teachersave",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean saveTeacher (Teacher teacher) throws Exception{
		boolean result=false;
		if (teacher.getTeacherId()!=null&&!"".equals(teacher.getTeacherId())) {
			result=userService.updateTeacherById(teacher);
		}else{
			result=userService.insertTeacher(teacher);			
		}
		
		
		return  result;
		
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
