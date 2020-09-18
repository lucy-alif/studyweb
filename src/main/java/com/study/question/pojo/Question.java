package com.study.question.pojo;

import java.util.Date;

public class Question {
    private Integer questionId;

    private String questionTitle;

    private Integer questionTypeid;

    private String questionTag1;

    private String questionTag2;

    private String questionTag3;

    private Integer questionUserid;

    private Integer questionVotenum;

    private Integer questionAnswernum;

    private Integer questionViewnum;

    private Integer questionStatus;

    private Date questionCreatetime;

    private Date questionModified;

    private String questionContent;

    public Integer getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Integer questionId) {
        this.questionId = questionId;
    }

    public String getQuestionTitle() {
        return questionTitle;
    }

    public void setQuestionTitle(String questionTitle) {
        this.questionTitle = questionTitle == null ? null : questionTitle.trim();
    }

    public Integer getQuestionTypeid() {
        return questionTypeid;
    }

    public void setQuestionTypeid(Integer questionTypeid) {
        this.questionTypeid = questionTypeid;
    }

    public String getQuestionTag1() {
        return questionTag1;
    }

    public void setQuestionTag1(String questionTag1) {
        this.questionTag1 = questionTag1 == null ? null : questionTag1.trim();
    }

    public String getQuestionTag2() {
        return questionTag2;
    }

    public void setQuestionTag2(String questionTag2) {
        this.questionTag2 = questionTag2 == null ? null : questionTag2.trim();
    }

    public String getQuestionTag3() {
        return questionTag3;
    }

    public void setQuestionTag3(String questionTag3) {
        this.questionTag3 = questionTag3 == null ? null : questionTag3.trim();
    }

    public Integer getQuestionUserid() {
        return questionUserid;
    }

    public void setQuestionUserid(Integer questionUserid) {
        this.questionUserid = questionUserid;
    }

    public Integer getQuestionVotenum() {
        return questionVotenum;
    }

    public void setQuestionVotenum(Integer questionVotenum) {
        this.questionVotenum = questionVotenum;
    }

    public Integer getQuestionAnswernum() {
        return questionAnswernum;
    }

    public void setQuestionAnswernum(Integer questionAnswernum) {
        this.questionAnswernum = questionAnswernum;
    }

    public Integer getQuestionViewnum() {
        return questionViewnum;
    }

    public void setQuestionViewnum(Integer questionViewnum) {
        this.questionViewnum = questionViewnum;
    }

    public Integer getQuestionStatus() {
        return questionStatus;
    }

    public void setQuestionStatus(Integer questionStatus) {
        this.questionStatus = questionStatus;
    }

    public Date getQuestionCreatetime() {
        return questionCreatetime;
    }

    public void setQuestionCreatetime(Date questionCreatetime) {
        this.questionCreatetime = questionCreatetime;
    }

    public Date getQuestionModified() {
        return questionModified;
    }

    public void setQuestionModified(Date questionModified) {
        this.questionModified = questionModified;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent == null ? null : questionContent.trim();
    }
}