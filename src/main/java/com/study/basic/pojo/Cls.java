package com.study.basic.pojo;

public class Cls {
    private Integer clsId;

    private String clsName;

    private Integer teacherId;

    private Integer managerId;

    private Integer clsroomId;

    private Integer clsStatus;

    public Integer getClsId() {
        return clsId;
    }

    public void setClsId(Integer clsId) {
        this.clsId = clsId;
    }

    public String getClsName() {
        return clsName;
    }

    public void setClsName(String clsName) {
        this.clsName = clsName == null ? null : clsName.trim();
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public Integer getManagerId() {
        return managerId;
    }

    public void setManagerId(Integer managerId) {
        this.managerId = managerId;
    }

    public Integer getClsroomId() {
        return clsroomId;
    }

    public void setClsroomId(Integer clsroomId) {
        this.clsroomId = clsroomId;
    }

    public Integer getClsStatus() {
        return clsStatus;
    }

    public void setClsStatus(Integer clsStatus) {
        this.clsStatus = clsStatus;
    }

	@Override
	public String toString() {
		return "Cls [clsId=" + clsId + ", clsName=" + clsName + ", teacherId=" + teacherId + ", managerId=" + managerId
				+ ", clsroomId=" + clsroomId + ", clsStatus=" + clsStatus + "]";
	}
    
    
}