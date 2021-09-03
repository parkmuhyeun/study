package com.hong.hakwon.dto;

import java.util.Date;

public class History {
    int id;
    String userId;
    String agent;
    Long datetime;


    public History() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAgent() {
        return agent;
    }

    public void setAgent(String agent) {
        this.agent = agent;
    }

    public Long getDatetime() {
        return datetime;
    }

    public void setDatetime(Long datetime) {
        this.datetime = datetime;
    }

    public History(String userId, String agent, Long datetime) {
        this.userId = userId;
        this.agent = agent;
        this.datetime = datetime;
    }
}
