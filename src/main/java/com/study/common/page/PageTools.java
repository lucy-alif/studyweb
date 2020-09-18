package com.study.common.page;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

//工具类
public class PageTools {
	//计算分页所需的当前区间
	/**
	 * currentPage:当前页数,showCount:显示的页码数量
	 */
	public static Integer calculatePagePeriod(Integer currentPage,Integer showCount){
		return (int)Math.floor((currentPage+showCount-1)/showCount);
	}
	
	public static void main(String[] args) {
		System.out.println(calculatePagePeriod(1,5));
		System.out.println(calculatePagePeriod(5,5));
		System.out.println(calculatePagePeriod(6,5));
		System.out.println(calculatePagePeriod(10,5));
		System.out.println(calculatePagePeriod(11,5));
		System.out.println(calculatePagePeriod(15,5));
	}
	
}
