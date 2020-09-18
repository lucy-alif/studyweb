package com.study.user.dao;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.user.pojo.Teacher;

public class TeacherMapperTest {

	@Test
	public void testSelectTeacherByTchNameAndPwd() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		TeacherMapper teacherMapper=(TeacherMapper)context.getBean("teacherMapper");
		
		Teacher t=new Teacher();
		t.setTeacherName("adminA");
		t.setTeacherPwd("8C7E1F3B1B787EC9F24FCC01E243E072");
		Teacher teacher=teacherMapper.selectByTchNameAndPwd(t);
		assertNotNull(teacher);
		System.out.println(teacher);
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

}
