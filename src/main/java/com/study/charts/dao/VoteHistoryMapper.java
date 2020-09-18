package com.study.charts.dao;

import java.util.List;

import com.study.charts.pojo.VoteHistory;

public interface VoteHistoryMapper {
    int deleteByPrimaryKey(Integer historyId);

    int insert(VoteHistory record);

    int insertSelective(VoteHistory record);

    VoteHistory selectByPrimaryKey(Integer historyId);

    int updateByPrimaryKeySelective(VoteHistory record);

    int updateByPrimaryKey(VoteHistory record);
    
    List<VoteHistory> showAllVote();
}