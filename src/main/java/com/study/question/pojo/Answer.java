package com.study.question.pojo;

import java.util.Date;

public class Answer {
    private Integer answerId;

    private Integer answerQuestionid;

    private Date answerCreatetime;

    private Integer answerUserid;

    private Integer answerVote;

    private Integer answerStatus;

    private Date answerModified;

    private String answerContent;

    public Integer getAnswerId() {
        return answerId;
    }

    public void setAnswerId(Integer answerId) {
        this.answerId = answerId;
    }

    public Integer getAnswerQuestionid() {
        return answerQuestionid;
    }

    public void setAnswerQuestionid(Integer answerQuestionid) {
        this.answerQuestionid = answerQuestionid;
    }

    public Date getAnswerCreatetime() {
        return answerCreatetime;
    }

    public void setAnswerCreatetime(Date answerCreatetime) {
        this.answerCreatetime = answerCreatetime;
    }

    public Integer getAnswerUserid() {
        return answerUserid;
    }

    public void setAnswerUserid(Integer answerUserid) {
        this.answerUserid = answerUserid;
    }

    public Integer getAnswerVote() {
        return answerVote;
    }

    public void setAnswerVote(Integer answerVote) {
        this.answerVote = answerVote;
    }

    public Integer getAnswerStatus() {
        return answerStatus;
    }

    public void setAnswerStatus(Integer answerStatus) {
        this.answerStatus = answerStatus;
    }

    public Date getAnswerModified() {
        return answerModified;
    }

    public void setAnswerModified(Date answerModified) {
        this.answerModified = answerModified;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent == null ? null : answerContent.trim();
    }
}