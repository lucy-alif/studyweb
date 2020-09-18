package com.study.basic.pojo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;



public class UserInfo {
    private Integer userId;

    private String userName;

    private String userLogin;

    private String userPasswd;

    private String userTelephone;

    private Byte userStatus;

    private String userAdditional;

    private String userHead;
    
   @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
   @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date userModified;

    private Cls cls;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserLogin() {
        return userLogin;
    }

    public void setUserLogin(String userLogin) {
        this.userLogin = userLogin == null ? null : userLogin.trim();
    }

    public String getUserPasswd() {
        return userPasswd;
    }

    public void setUserPasswd(String userPasswd) {
        this.userPasswd = userPasswd == null ? null : userPasswd.trim();
    }

    public String getUserTelephone() {
        return userTelephone;
    }

    public void setUserTelephone(String userTelephone) {
        this.userTelephone = userTelephone == null ? null : userTelephone.trim();
    }

    public Byte getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(Byte userStatus) {
        this.userStatus = userStatus;
    }

    public String getUserAdditional() {
        return userAdditional;
    }

    public void setUserAdditional(String userAdditional) {
        this.userAdditional = userAdditional == null ? null : userAdditional.trim();
    }

    public String getUserHead() {
        return userHead;
    }

    public void setUserHead(String userHead) {
        this.userHead = userHead == null ? null : userHead.trim();
    }

  
    public Date getUserModified() {
        return userModified;
    }


    public void setUserModified(Date userModified) {
        this.userModified = userModified;
    }

	public Cls getCls() {
		return cls;
	}

	public void setCls(Cls cls) {
		this.cls = cls;
	}

	@Override
	public String toString() {
		return "UserInfo [userId=" + userId + ", userName=" + userName + ", userLogin=" + userLogin + ", userPasswd="
				+ userPasswd + ", userTelephone=" + userTelephone + ", userStatus=" + userStatus + ", userAdditional="
				+ userAdditional + ", userHead=" + userHead + ", userModified=" + userModified + ", cls=" + cls + "]";
	}

 
    
    
}