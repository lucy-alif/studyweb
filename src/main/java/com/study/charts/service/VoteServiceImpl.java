package com.study.charts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.study.charts.dao.VoteHistoryMapper;
import com.study.charts.pojo.VoteHistory;

@Service
public class VoteServiceImpl implements IVoteService{
	@Autowired
	private VoteHistoryMapper voteHistoryMapper;

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<VoteHistory> showAllVote() {
		
		return voteHistoryMapper.showAllVote();
	}

}
