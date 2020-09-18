package com.study.basic.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

 
import com.study.basic.pojo.UserInfo;

public class UserInfoMapperTest {

	@Test
	public void testListAllUser() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		UserInfoMapper userInfoMapper=(UserInfoMapper)context.getBean("userInfoMapper");
		
		List<UserInfo> list= userInfoMapper.listAllUserInfo();
		for (UserInfo userInfo : list) {
			System.out.println(userInfo);
		}
		assertTrue(list.size()>0);
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}
	
	@Test
	public void tesselectUserById() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		UserInfoMapper userInfoMapper=(UserInfoMapper)context.getBean("userInfoMapper");
		
		UserInfo user=userInfoMapper.selectByPrimaryKey(1);
		assertNotNull(user);
		System.out.println(user);
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

}
