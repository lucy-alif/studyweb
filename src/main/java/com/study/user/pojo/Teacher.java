package com.study.user.pojo;

public class Teacher {
    private Integer teacherId;

    private String teacherName;

    private String teacherPwd;

    private String teacherNickname;

    private Integer roleId;

    private Integer teacherStatus;

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName == null ? null : teacherName.trim();
    }

    public String getTeacherPwd() {
        return teacherPwd;
    }

    public void setTeacherPwd(String teacherPwd) {
        this.teacherPwd = teacherPwd == null ? null : teacherPwd.trim();
    }

    public String getTeacherNickname() {
        return teacherNickname;
    }

    public void setTeacherNickname(String teacherNickname) {
        this.teacherNickname = teacherNickname == null ? null : teacherNickname.trim();
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getTeacherStatus() {
        return teacherStatus;
    }

    public void setTeacherStatus(Integer teacherStatus) {
        this.teacherStatus = teacherStatus;
    }

	@Override
	public String toString() {
		return "Teacher [teacherId=" + teacherId + ", teacherName=" + teacherName + ", teacherPwd=" + teacherPwd
				+ ", teacherNickname=" + teacherNickname + ", roleId=" + roleId + ", teacherStatus=" + teacherStatus
				+ "]";
	}
    
    
    
}