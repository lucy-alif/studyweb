package com.study.user.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.user.pojo.Role;

public class RoleMapperTest {

	@Test
	public void testListAllRole() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		RoleMapper roleMapper=(RoleMapper)context.getBean("roleMapper");
		
		List<Role> roles=roleMapper.listAllRole();
		assertTrue(roles.size()>0);
		
		for (Role role : roles) {
			System.out.println(role);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	
	@Test
	public void testRoleAndRight() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		RoleMapper roleMapper=(RoleMapper)context.getBean("roleMapper");
		
		Role role=roleMapper.queryRoleAndRightByRoleId(1);
		assertNotNull(role);
		System.out.println(role);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	
	@Test
	public void testaddRole() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		RoleMapper roleMapper=(RoleMapper)context.getBean("roleMapper");
		
		Role role=new Role();
		role.setRoleName("测试角色2");
		int row=roleMapper.insertSelective(role);
		assertTrue(row>0);
		System.out.println(role);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

}
