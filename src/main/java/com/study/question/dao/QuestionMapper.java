package com.study.question.dao;

import java.util.List;

import com.study.common.page.PageInfo;
import com.study.question.pojo.Question;

public interface QuestionMapper {
    int deleteByPrimaryKey(Integer questionId);

    int insert(Question record);

    int insertSelective(Question record);

    Question selectByPrimaryKey(Integer questionId);
    
    List<Question> listPageAllQuestion(PageInfo pageInfo);
    
    List<Question> showAllQuestion();

    int updateByPrimaryKeySelective(Question record);

    int updateByPrimaryKeyWithBLOBs(Question record);

    int updateByPrimaryKey(Question record);
}