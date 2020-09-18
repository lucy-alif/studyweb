package com.study.charts.pojo;

public class VoteHistory {
    private Integer historyId;

    private Integer historyQuestionid;

    private Integer historyAnswerid;

    private Integer historyUserid;

    public Integer getHistoryId() {
        return historyId;
    }

    public void setHistoryId(Integer historyId) {
        this.historyId = historyId;
    }

    public Integer getHistoryQuestionid() {
        return historyQuestionid;
    }

    public void setHistoryQuestionid(Integer historyQuestionid) {
        this.historyQuestionid = historyQuestionid;
    }

    public Integer getHistoryAnswerid() {
        return historyAnswerid;
    }

    public void setHistoryAnswerid(Integer historyAnswerid) {
        this.historyAnswerid = historyAnswerid;
    }

    public Integer getHistoryUserid() {
        return historyUserid;
    }

    public void setHistoryUserid(Integer historyUserid) {
        this.historyUserid = historyUserid;
    }

	@Override
	public String toString() {
		return "VoteHistory [historyId=" + historyId + ", historyQuestionid=" + historyQuestionid + ", historyAnswerid="
				+ historyAnswerid + ", historyUserid=" + historyUserid + "]";
	}
    
    
}