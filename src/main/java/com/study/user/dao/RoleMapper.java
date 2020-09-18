package com.study.user.dao;

import java.util.List;

import com.study.user.pojo.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer roleId);
    
    List<Role> listAllRole();

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    
    /**
     * 根据角色id查询角色信息，包括角色的具体权限
     * @param roleId
     * @return
     */
   Role queryRoleAndRightByRoleId(Integer roleId);
}