package com.study.basic.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.basic.pojo.Cls;
import com.study.basic.pojo.ClsRoom;
import com.study.basic.pojo.UserInfo;
import com.study.common.page.PageInfo;


public class BasicServiceTest {

	@Test
	public void testListAllClsRoom() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IBasicService basicService=(IBasicService)context.getBean("basicServiceImpl");
		
		List<ClsRoom> lists=basicService.listAllClsRoom();
		assertTrue(lists.size()>0);
		for (ClsRoom clsRoom : lists) {
			System.out.println(clsRoom);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	@Test
	public void testUpdateClsRoomStatus() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IBasicService basicService=(IBasicService)context.getBean("basicServiceImpl");
		
		ClsRoom clsRoom=new ClsRoom();
		clsRoom.setClsroomId(12);
		clsRoom.setClsroomStatus(0);
		boolean result=basicService.updateClsRoomStatus(clsRoom);
		assertTrue(result);
		
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

	
	@Test
	public void testListAllUserinfo() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IBasicService basicService=(IBasicService)context.getBean("basicServiceImpl");
		
		List<UserInfo> lists=basicService.listAllUserInfo();
		assertTrue(lists.size()>0);
		for (UserInfo userInfo : lists) {
			System.out.println(userInfo);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	@Test
	public void testListAllCls() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IBasicService basicService=(IBasicService)context.getBean("basicServiceImpl");
		
		List<Cls> lists=basicService.listAllCls();
		assertTrue(lists.size()>0);
		for (Cls cls : lists) {
			System.out.println(cls);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	
	
	@Test
	public void testUserinfoLogin() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IBasicService basicService=(IBasicService)context.getBean("basicServiceImpl");
		
		UserInfo  userInfo=new UserInfo();
		userInfo.setUserLogin("lucy");
		userInfo.setUserPasswd("123456");
		userInfo=basicService.userInfoLogin(userInfo);
		assertNotNull(userInfo);
		System.out.println(userInfo);
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
}
