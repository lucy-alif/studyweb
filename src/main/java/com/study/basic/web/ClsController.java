package com.study.basic.web;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.study.basic.pojo.Cls;
import com.study.basic.pojo.ClsRoom;
import com.study.basic.pojo.UserInfo;
import com.study.basic.service.IBasicService;
import com.study.user.pojo.Teacher;
import com.study.user.service.IUserService;

@Controller
@RequestMapping("/basic")
public class ClsController {
	@Autowired
	private IBasicService basicService;
	@Autowired
	private IUserService userService;
	
	@RequestMapping(path="/clsmain",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView showAllCls() {
		
		List<Cls> cls=basicService.listAllCls();
		List<ClsRoom> clsRooms=basicService.listAllClsRoom();
		List<Teacher> teachers=userService.listAllTeacher();
		ModelAndView mView=new ModelAndView();
		if (cls.size()>0) {
			
			mView.addObject("cls",cls);
			mView.addObject("clsRooms",clsRooms);
			mView.addObject("teachers",teachers);
		}else {
			mView.addObject("msg","当前无班级信息");
		}
		
		mView.setViewName("back/cls");
		return mView;	
	}
	
	@RequestMapping(path="/clsdel",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean deleteUserinfo(@RequestBody Cls cls) {		
		boolean result=basicService.deleteCls(cls);
		
		return result;	
	}
	
	@RequestMapping(path="/selectClsForEdit",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Cls selectUserForEdit(Integer id) {
		Cls cls=basicService.queryClsById(id);
		
		return cls;	
	}
	@RequestMapping(path="/clssave",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean saveCls(Cls cls) {		
		System.out.println(cls);
		boolean result=false;
		if (cls.getClsId()!=null) {//修改
			result=basicService.deleteCls(cls);
			
		}else {//新增	
			result=basicService.addCls(cls);
		}
		return result;
		
	}
}
