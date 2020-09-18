package com.study.user.pojo;

public class Rights {
    private Integer rightId;

    private String rightName;

    private String rightUrl;

    public Integer getRightId() {
        return rightId;
    }

    public void setRightId(Integer rightId) {
        this.rightId = rightId;
    }

    public String getRightName() {
        return rightName;
    }

    public void setRightName(String rightName) {
        this.rightName = rightName == null ? null : rightName.trim();
    }

    public String getRightUrl() {
        return rightUrl;
    }

    public void setRightUrl(String rightUrl) {
        this.rightUrl = rightUrl == null ? null : rightUrl.trim();
    }

    
    
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((rightId == null) ? 0 : rightId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Rights other = (Rights) obj;
		if (rightId == null) {
			if (other.rightId != null)
				return false;
		} else if (!rightId.equals(other.rightId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Rights [rightId=" + rightId + ", rightName=" + rightName + ", rightUrl=" + rightUrl + "]";
	}
    
    
}