package com.study.basic.dao;

import static org.junit.Assert.assertTrue;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.basic.pojo.ClsRoom;
import com.study.common.page.PageInfo;

public class ClsRoomMapperTest {

	@Test
	public void testListAllClaRoom() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		ClsRoomMapper clsRoomMapper=(ClsRoomMapper)context.getBean("clsRoomMapper");
		
		List<ClsRoom> lists=clsRoomMapper.listAllClsRoom();
		assertTrue(lists.size()>0);
		for (ClsRoom clsRoom : lists) {
			System.out.println(clsRoom);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

}
