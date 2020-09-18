package com.study.basic.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.study.basic.pojo.ClsRoom;
import com.study.basic.service.IBasicService;

@Controller
@RequestMapping("/basic")
public class ClsRoomController {
	@Autowired
	private IBasicService basicService;
	
	
	@RequestMapping(path="/clsRoommain",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView showAllClsRoom() {
		
		List<ClsRoom> clsRooms=basicService.listAllClsRoom();
		ModelAndView mView=new ModelAndView();
		if (clsRooms.size()>0) {
			mView.addObject("clsRooms",clsRooms);
		}else {
			mView.addObject("msg","当前无班级信息");
		}
		
		mView.setViewName("back/clsroom");
		return mView;
		
	}
	
	
	@RequestMapping(path="/clsRoomdel",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody boolean updateClsRoomStatus(@RequestBody ClsRoom clsRoom) {
		
		boolean result=false;
		result=basicService.updateClsRoomStatus(clsRoom);
		
		return result;
		
	}
	
	@RequestMapping(path="/clsroomedit",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody ClsRoom updateClsRoom(Integer id) {
		
		ClsRoom clsRoom=basicService.queryClsRoomById(id);
		
		return clsRoom;
		
	}
	
	@RequestMapping(path="/clsroomsave",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody ClsRoom saveClsRoom(ClsRoom clsRoom) {
		if (clsRoom.getClsroomId()!=null&&!"".equals(clsRoom.getClsroomId())) {//有ID是修改
			
			clsRoom=basicService.updateClsRoomName(clsRoom);
		}else{//无ID是新增			
			
			clsRoom=basicService.addClsRoom(clsRoom);
			
		}
		return clsRoom;	
	}
	


}
