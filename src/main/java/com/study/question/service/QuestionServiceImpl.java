package com.study.question.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.study.common.page.PageInfo;
import com.study.question.dao.AnswerMapper;
import com.study.question.dao.QuestionMapper;
import com.study.question.pojo.Answer;
import com.study.question.pojo.Question;

@Service
public class QuestionServiceImpl implements IQuestionService{
	@Autowired QuestionMapper questionMapper;
	@Autowired AnswerMapper answerMapper;
	
	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<Question> listAllQuestion(PageInfo pageInfo) {
		 
		return questionMapper.listPageAllQuestion(pageInfo);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean addQuestion(Question question) {
		 
		return questionMapper.insertSelective(question)>0;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public Question queryQuestionById(Integer id) {
		 
		return questionMapper.selectByPrimaryKey(id);
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<Answer> queryAllAnswersByQuestionId(Integer questionId) {
		// 
		return answerMapper.queryAllAnswersByQuestionId(questionId);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean addAnswer(Answer answer) {
		 
		return answerMapper.insertSelective(answer)>0;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<Question> showAllQuestion() {
		// 
		return questionMapper.showAllQuestion();
	}
	
	

}
