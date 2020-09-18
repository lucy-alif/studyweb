package com.study.user.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.user.pojo.Role;
import com.study.user.pojo.Teacher;

public class UserServiceImplTest {

	@Test
	public void testLoginByTchNameAndPwd() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IUserService userService=(IUserService)context.getBean("userServiceImpl");
		
		Teacher t=new Teacher();
		t.setTeacherName("adminA");
		t.setTeacherPwd("123456");
		
		Teacher teacher=userService.loginByTchNameAndPwd(t);
		assertNotNull(teacher);
		System.out.println(teacher);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	

	@Test
	public void testListAllRole() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IUserService userService=(IUserService)context.getBean("userServiceImpl");
		
		List<Role> roles=userService.listAllRole();
		assertTrue(roles.size()>0);
		for (Role role : roles) {
			System.out.println(role);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	@Test
	public void testUpdateRole() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IUserService userService=(IUserService)context.getBean("userServiceImpl");
		
		Role role=new Role();
		role.setRoleId(1);
		role.setRoleName("讲师");
		role=userService.updateRole(role);
		assertNotNull(role);
		System.out.println(role);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

}
