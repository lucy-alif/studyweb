package com.study.basic.dao;

import java.util.List;

import com.study.basic.pojo.Cls;

public interface ClsMapper {
    int deleteByPrimaryKey(Integer clsId);

    int insert(Cls record);

    int insertSelective(Cls record);

    Cls selectByPrimaryKey(Integer clsId);
    List<Cls> listAllCls();

    int updateByPrimaryKeySelective(Cls record);

    int updateByPrimaryKey(Cls record);
}