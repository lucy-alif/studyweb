package com.study.question.web;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.study.basic.pojo.UserInfo;
import com.study.basic.service.IBasicService;
import com.study.common.page.PageInfo;
import com.study.question.pojo.Answer;
import com.study.question.pojo.Question;
import com.study.question.service.IQuestionService;
import com.study.user.service.IUserService;

@Controller
@RequestMapping("/question")
public class QuestionController {
	@Autowired IQuestionService questionService;
	@Autowired IBasicService basicService;
	
	
	
	@RequestMapping(path="/putquestion", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView toAsk() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("front/ask");
		return mv;
	}
	
	//返回按钮功能暂未实现
	@RequestMapping(path="/questionlist", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView returnList(Integer typeId) {
		ModelAndView mv=new ModelAndView();
		
		System.out.println("返回");
		mv.setViewName("front/index");
		return mv;
	}
	
	
	@RequestMapping(path="/showAll", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView showQuestionList(PageInfo pageInfo,HttpSession session) {
		ModelAndView mv=new ModelAndView();
		List<Question> qList=questionService.listAllQuestion(pageInfo);
		List<UserInfo> userList=basicService.listAllUserInfo();
		System.out.println(qList);
		System.out.println("listAll");
		session.setAttribute("token", UUID.randomUUID().toString());
		mv.addObject("qList", qList);
		mv.addObject("userList", userList);
		mv.setViewName("front/index");
		return mv;
	}
	
	@RequestMapping(path="/savequestion", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView addQuestion(String token,Question question,HttpSession session) {
		ModelAndView mv=new ModelAndView();
		if (token.equals(session.getAttribute("token"))) {
			UserInfo userInfo=(UserInfo)(session.getAttribute("userInfo"));
			question.setQuestionUserid(userInfo.getUserId());
			questionService.addQuestion(question);
		}
		
		mv.setViewName("forward:/question/showAll");
		return mv;
	}
	
	@RequestMapping(path="/showquestion", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView showQuestionDetails(Integer id) {
		ModelAndView mv=new ModelAndView();
		Question question=questionService.queryQuestionById(id);
		UserInfo whoAsk=basicService.selectUserById(question.getQuestionUserid());
		List<Answer> answerList=questionService.queryAllAnswersByQuestionId(id);
		List<UserInfo> userInfos=basicService.listAllUserInfo();
		
		mv.addObject("question", question);
		mv.addObject("whoAsk", whoAsk);
		mv.addObject("answerList", answerList);
		mv.addObject("userInfos", userInfos);
		mv.setViewName("front/questiondetails");
		return mv;
	}
	
	@RequestMapping(path="/saveanswer", method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView addAnswer(String token,Answer answer ,HttpSession session) {
		ModelAndView mv=new ModelAndView();
		if (token.equals(session.getAttribute("token"))) {
			UserInfo userInfo=(UserInfo)(session.getAttribute("userInfo"));
			answer.setAnswerUserid(userInfo.getUserId());
			questionService.addAnswer(answer);
		}
		
		mv.setViewName("forward:/question/showAll");
		return mv;
	}

}
