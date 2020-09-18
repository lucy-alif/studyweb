package com.study.question.dao;

import com.study.question.pojo.QuestionType;

public interface QuestionTypeMapper {
    int deleteByPrimaryKey(Integer questiontypeId);

    int insert(QuestionType record);

    int insertSelective(QuestionType record);

    QuestionType selectByPrimaryKey(Integer questiontypeId);

    int updateByPrimaryKeySelective(QuestionType record);

    int updateByPrimaryKey(QuestionType record);
}