package com.study.basic.vo;

import java.util.Date;
import java.util.List;

import com.study.basic.pojo.Cls;
import com.study.basic.pojo.UserInfo;

public class UserVO {
    private UserInfo user;

    private List<Cls> clsList;

	public UserInfo getUser() {
		return user;
	}

	public void setUser(UserInfo user) {
		this.user = user;
	}

	public List<Cls> getClsList() {
		return clsList;
	}

	public void setClsList(List<Cls> clsList) {
		this.clsList = clsList;
	}
    
    
    
    

    
    
}