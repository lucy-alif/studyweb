package com.study.basic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.study.basic.dao.ClsMapper;
import com.study.basic.dao.ClsRoomMapper;
import com.study.basic.dao.UserInfoMapper;
import com.study.basic.pojo.Cls;
import com.study.basic.pojo.ClsRoom;
import com.study.basic.pojo.UserInfo;
import com.study.common.util.MD5;


@Service
public class BasicServiceImpl implements IBasicService{
	
	@Autowired
	private ClsRoomMapper clsroomMapper;
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private ClsMapper clsMapper;

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<ClsRoom> listAllClsRoom() {
		 
		return clsroomMapper.listAllClsRoom();
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean updateClsRoomStatus(ClsRoom clsRoom) {
		
		return clsroomMapper.updateByPrimaryKeySelective(clsRoom)>0;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	@Cacheable(cacheNames="default", key="#clsroomId+''",unless="#result==null")
	public ClsRoom queryClsRoomById(Integer clsroomId) {
		 
		return clsroomMapper.selectByPrimaryKey(clsroomId);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	 @CachePut(cacheNames="default",key="#clsRoom.clsroomId+''")
	public ClsRoom updateClsRoomName(ClsRoom clsRoom) {
		ClsRoom cls=null;
		 if (clsroomMapper.updateByPrimaryKeySelective(clsRoom)>0) {
			cls=clsroomMapper.selectByPrimaryKey(clsRoom.getClsroomId());
		}
		return cls ;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public ClsRoom addClsRoom(ClsRoom clsRoom) {
		if (clsroomMapper.insertSelective(clsRoom)>0) {
			clsRoom.setClsroomStatus(1);//新增的教室默认有效
			return clsRoom;
		}
		return clsRoom;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<UserInfo> listAllUserInfo() {
		 
		return userInfoMapper.listAllUserInfo();
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean deleteUser(UserInfo userInfo) {
		
		return userInfoMapper.updateByPrimaryKeySelective(userInfo)>0;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<Cls> listAllCls() {
		 
		return clsMapper.listAllCls();
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public UserInfo selectUserById(Integer userId) {
		 
		return userInfoMapper.selectByPrimaryKey(userId);
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public Cls queryClsById(Integer clsId) {
		
		return clsMapper.selectByPrimaryKey(clsId);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean addUser(UserInfo userInfo) {
		userInfo.setUserPasswd(MD5.enctypeMD5(userInfo.getUserPasswd()));
		return userInfoMapper.insertSelective(userInfo)>0;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean deleteCls(Cls cls) {
		 
		return clsMapper.updateByPrimaryKeySelective(cls)>0;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean addCls(Cls cls) {
		
		return clsMapper.insertSelective(cls)>0;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public UserInfo userInfoLogin(UserInfo userInfo) {
		 userInfo.setUserPasswd(MD5.enctypeMD5("haha"+userInfo.getUserPasswd()));
		return userInfoMapper.selectUserByNameAndPwd(userInfo);
	}

}
