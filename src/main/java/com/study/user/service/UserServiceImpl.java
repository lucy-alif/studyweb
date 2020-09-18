package com.study.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NestedCheckedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.study.common.util.MD5;
import com.study.user.dao.RoleMapper;
import com.study.user.dao.RoleRightsMapper;
import com.study.user.dao.TeacherMapper;
import com.study.user.pojo.Rights;
import com.study.user.pojo.Role;
import com.study.user.pojo.RoleRightsKey;
import com.study.user.pojo.Teacher;


@Service
public class UserServiceImpl implements IUserService{
	
	@Autowired
	private TeacherMapper teacherMapper;
	
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private RoleRightsMapper roleRightsMapper;

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public Teacher loginByTchNameAndPwd(Teacher teacher) {
		
		teacher.setTeacherPwd(MD5.enctypeMD5("haha"+teacher.getTeacherPwd()));
		
		return teacherMapper.selectByTchNameAndPwd(teacher);
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<Role> listAllRole() {
		 
		return roleMapper.listAllRole();
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public Role queryRoleAndRightByRoleId(Integer roleId) {
		
		return roleMapper.queryRoleAndRightByRoleId(roleId);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public void modifyRoleRights(Integer roleId, List<Integer> newRights) {
		   //查出对应角色的所有权限
		Role role=roleMapper.queryRoleAndRightByRoleId(roleId);
		List<Rights> oldRights=role.getRightList();
		
		//新权限为空
		if (newRights==null&&oldRights.size()>0) {//没有新权限，删除所有旧权限
			for (Rights rights : oldRights) {
				RoleRightsKey rk=new RoleRightsKey();
				rk.setRoleId(roleId);
				rk.setRightId(rights.getRightId());
				roleRightsMapper.deleteByPrimaryKey(rk);
			}
		}
		if (newRights!=null&&oldRights.size()==0) {//没有旧权限，新增权限
			for (Integer rights : newRights) {
				RoleRightsKey rk=new RoleRightsKey();
				rk.setRoleId(roleId);
				rk.setRightId(rights);
				roleRightsMapper.insert(rk);
			}
		}
		if (newRights!=null&&oldRights.size()>0) {//有新权限，有旧权限  去异存同
			for (Rights rights : oldRights) {
				if (!newRights.contains(rights.getRightId())) {//在新权限中不存在该旧权限，删除旧权限
					RoleRightsKey rk=new RoleRightsKey();
					rk.setRoleId(roleId);
					rk.setRightId(rights.getRightId());
					roleRightsMapper.deleteByPrimaryKey(rk);
				}
			}
			
			for (Integer rights : newRights) {//旧权限中不存在该新权限，添加新权限
				Rights newRight=new Rights();
				newRight.setRightId(rights);
				if (!oldRights.contains(newRight)) {/*将新权限的id放进一个新的Right对象中，判断旧权限集合中是否
				包含这个Right对象，此处需要重写Right类中的equals方法*/
					RoleRightsKey rk=new RoleRightsKey();
					rk.setRoleId(roleId);
					rk.setRightId(rights);
					roleRightsMapper.insert(rk);
				}
			}
			
		}
		
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public Role updateRole(Role role) {
		Role r=new Role();
		if (roleMapper.updateByPrimaryKeySelective(role)>0) {
			r=roleMapper.queryRoleAndRightByRoleId(role.getRoleId());
		}
		return r;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public Role selectRoleById(Integer roleId) {
		 
		return roleMapper.selectByPrimaryKey(roleId);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean addRole(Role role) {
		 
		return roleMapper.insertSelective(role)>0;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean deleteRole(Integer roleId) {
		
		return roleMapper.deleteByPrimaryKey(roleId)>0;
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public List<Teacher> listAllTeacher() {
		
		return teacherMapper.listAllTeacher();
	}

	@Override
	@Transactional(propagation=Propagation.SUPPORTS,isolation=Isolation.DEFAULT,readOnly=true)
	public Teacher queryTeacherById(Integer teacherId) {
		 
		return teacherMapper.selectByPrimaryKey(teacherId);
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean updateTeacherById(Teacher teacher) {
		 
		return teacherMapper.updateByPrimaryKeySelective(teacher)>0;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean insertTeacher(Teacher teacher) {
		 
		return teacherMapper.insertSelective(teacher)>0;
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED,isolation=Isolation.DEFAULT,rollbackFor=Exception.class)
	public boolean deleteTeacherStatus(Teacher teacher) {
		 
		return teacherMapper.updateByPrimaryKeySelective(teacher)>0;
	}

}
