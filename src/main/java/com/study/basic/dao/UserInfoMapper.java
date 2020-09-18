package com.study.basic.dao;

import java.util.List;

import com.study.basic.pojo.UserInfo;

public interface UserInfoMapper {
    int deleteByPrimaryKey(Integer userId);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer userId);
    
    UserInfo selectUserByNameAndPwd(UserInfo userInfo);
      
    List<UserInfo> listAllUserInfo();

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);
}