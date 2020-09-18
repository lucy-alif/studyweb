package com.study.user.dao;

import java.util.List;

import com.study.user.pojo.Teacher;

public interface TeacherMapper {
    int deleteByPrimaryKey(Integer teacherId);

    int insert(Teacher record);

    int insertSelective(Teacher record);

    Teacher selectByPrimaryKey(Integer teacherId);
    
    List<Teacher> listAllTeacher();
    
    Teacher selectByTchNameAndPwd(Teacher teacher);

    int updateByPrimaryKeySelective(Teacher record);

    int updateByPrimaryKey(Teacher record);
}