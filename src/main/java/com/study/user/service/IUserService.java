package com.study.user.service;

import java.util.List;

import com.study.user.pojo.Role;
import com.study.user.pojo.Teacher;

public interface IUserService {
	
	/**
	 * 使用教师名和密码登录后台
	 * @param teacher
	 * @return
	 */
	Teacher loginByTchNameAndPwd(Teacher teacher);
	
	
	List<Role> listAllRole();
	
	List<Teacher> listAllTeacher();
	
	 Role queryRoleAndRightByRoleId(Integer roleId);
	 
	 Role selectRoleById(Integer roleId);
	 
	 /**
	  * 更新对应角色的权限
	  * @param roleId 角色id
	  * @param newRights 新权限的id的集合
	  * @return
	  */
	 void modifyRoleRights(Integer roleId,List<Integer> newRights);
	 
	 Role updateRole(Role role);
	 
	 boolean addRole(Role role);
	 
	 boolean deleteRole(Integer roleId);
	 
	 Teacher queryTeacherById(Integer teacherId);
	 
	 boolean updateTeacherById(Teacher teacher);
	 
	 boolean insertTeacher(Teacher teacher);
	 
	 boolean deleteTeacherStatus(Teacher teacher);
}
