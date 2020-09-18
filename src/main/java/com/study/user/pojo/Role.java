package com.study.user.pojo;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@JsonIgnoreProperties(value = { "handler" })
public class Role {
    private Integer roleId;

    private String roleName;
    
    private List<Rights> rightList;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

	public List<Rights> getRightList() {
		return rightList;
	}

	public void setRightList(List<Rights> rightList) {
		this.rightList = rightList;
	}

	@Override
	public String toString() {
		return "Role [roleId=" + roleId + ", roleName=" + roleName + ", rightList=" + rightList + "]";
	}


    
    
}