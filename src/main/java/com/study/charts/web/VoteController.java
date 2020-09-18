package com.study.charts.web;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.study.charts.vo.Children;
import com.study.charts.vo.Option;
import com.study.charts.vo.Series;
import com.study.charts.vo.Series.Data;
import com.study.question.pojo.Answer;
import com.study.question.pojo.Question;
import com.study.question.service.IQuestionService;

@Controller
@RequestMapping("/vote")
public class VoteController {
	@Autowired
	private IQuestionService questionService;
	
	
	@RequestMapping(path="/votemain",method={RequestMethod.GET,RequestMethod.POST})
	public ModelAndView toVote(){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("back/votemain");
		return mv;
	}
	
	@RequestMapping(path="/showVote",method={RequestMethod.GET,RequestMethod.POST})
	public @ResponseBody Option showVote() {
		Series series=new Series();	
		series.setType("sunburst");	
		
		List<Question> questions=questionService.showAllQuestion();//所有question
		
		Data[] data=new Data[questions.size()];
		for (int i = 0; i < questions.size(); i++) {
			Data d=series. new Data();
			d.setName(questions.get(i).getQuestionTitle());
			d.setValue(questions.get(i).getQuestionAnswernum());
			
			//查询该问题对应的所有答案
			List<Answer> answers=questionService.queryAllAnswersByQuestionId(questions.get(i).getQuestionId());
			Children[] children=new Children[answers.size()];
			for (int j = 0; j < answers.size(); j++) {
				Children c=new Children();
				c.setValue(answers.get(j).getAnswerVote());	
				c.setName(answers.get(j).getAnswerVote()+"票");
				
				
				children[j]=c;
			}
			
			d.setChildren(children);
			data[i]=d;
		}
		
		
		series.setData(data);
		
		Option option=new Option();
		option.setSeries(series);
		System.out.println(option);
		
		return option;
	}

}
