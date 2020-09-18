package com.study.user.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.user.pojo.RoleRightsKey;


public class RoleRightsMapperTest {

	@Test
	public void testAddRoleRights() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		RoleRightsMapper roleRightsMapper=(RoleRightsMapper)context.getBean("roleRightsMapper");
		
		RoleRightsKey roleRightsKey=new RoleRightsKey();
		roleRightsKey.setRoleId(2);
		roleRightsKey.setRightId(12);
		
		int count=roleRightsMapper.insert(roleRightsKey);
		assertTrue(count>0);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

	

	@Test
	public void testDeleteRoleRights() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		RoleRightsMapper roleRightsMapper=(RoleRightsMapper)context.getBean("roleRightsMapper");
		
		RoleRightsKey roleRightsKey=new RoleRightsKey();
		roleRightsKey.setRoleId(2);
		roleRightsKey.setRightId(12);
		
		int count=roleRightsMapper.deleteByPrimaryKey(roleRightsKey);
		assertTrue(count>0);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
}
