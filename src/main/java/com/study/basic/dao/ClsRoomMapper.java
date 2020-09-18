package com.study.basic.dao;

import java.util.List;

import com.study.basic.pojo.ClsRoom;

public interface ClsRoomMapper {
    int deleteByPrimaryKey(Integer clsroomId);

    int insert(ClsRoom record);

    int insertSelective(ClsRoom record);

    ClsRoom selectByPrimaryKey(Integer clsroomId);
    //分页方法的名字必须要以listPage开头,传入pageInfo作为形参
    List<ClsRoom> listAllClsRoom();

    int updateByPrimaryKeySelective(ClsRoom record);

    int updateByPrimaryKey(ClsRoom record);
}