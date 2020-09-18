package com.study.basic.service;

import java.util.List;

import com.study.basic.pojo.Cls;
import com.study.basic.pojo.ClsRoom;
import com.study.basic.pojo.UserInfo;

public interface IBasicService {

	
	List<ClsRoom> listAllClsRoom();
	
	List<UserInfo> listAllUserInfo();
	
	List<Cls> listAllCls();
	
	boolean updateClsRoomStatus(ClsRoom clsRoom);
	
	ClsRoom queryClsRoomById(Integer clsroomId);
	
	ClsRoom updateClsRoomName(ClsRoom clsRoom);
	
	ClsRoom addClsRoom(ClsRoom clsRoom);
	
	UserInfo selectUserById(Integer userId);
	
	UserInfo  userInfoLogin(UserInfo userInfo);
	
	boolean deleteUser(UserInfo userInfo);
	
	boolean addUser(UserInfo userInfo);
	
	Cls queryClsById(Integer clsId);
	
	boolean deleteCls(Cls cls);
	
	boolean addCls(Cls cls);
}
