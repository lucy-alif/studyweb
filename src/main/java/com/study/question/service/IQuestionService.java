package com.study.question.service;

import java.util.List;

import com.study.common.page.PageInfo;
import com.study.question.pojo.Answer;
import com.study.question.pojo.Question;

public interface IQuestionService {

	List<Question> listAllQuestion(PageInfo pageInfo);
	List<Question>showAllQuestion();
	
	boolean addQuestion(Question question);
	
	Question queryQuestionById(Integer id);

	List<Answer> queryAllAnswersByQuestionId(Integer questionId);
	
	boolean addAnswer(Answer answer);
	
}
