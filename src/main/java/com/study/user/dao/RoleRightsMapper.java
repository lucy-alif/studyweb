package com.study.user.dao;

import com.study.user.pojo.RoleRightsKey;

public interface RoleRightsMapper {
    int deleteByPrimaryKey(RoleRightsKey key);

    int insert(RoleRightsKey record);

    int insertSelective(RoleRightsKey record);
}