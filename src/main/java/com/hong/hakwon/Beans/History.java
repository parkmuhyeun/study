package com.hong.hakwon.Beans;

public class History {
    private int id;
    private String userId;
    private String agent;
    private Long datetime;


    public History() {
    }

    public int getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public String getAgent() {
        return agent;
    }

    public Long getDatetime() {
        return datetime;
    }

    public History(String userId, String agent, Long datetime) {
        this.userId = userId;
        this.agent = agent;
        this.datetime = datetime;
    }
}
