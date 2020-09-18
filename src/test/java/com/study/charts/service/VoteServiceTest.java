package com.study.charts.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.study.charts.pojo.VoteHistory;

public class VoteServiceTest {

	@Test
	public void testShowAllVote() throws Exception{
		ApplicationContext context=new ClassPathXmlApplicationContext("springmvc.xml");
		IVoteService voteServiceImpl=(IVoteService)context.getBean("voteServiceImpl");
		
		List<VoteHistory> voteHistories=voteServiceImpl.showAllVote();
		assertTrue(voteHistories.size()>0);
		for (VoteHistory voteHistory : voteHistories) {
			System.out.println(voteHistory);
		}
		
		((ClassPathXmlApplicationContext)context).registerShutdownHook();
	}

}
