package com.hong.hakwon.web.dto;

public class LoginForm {
    private String Id;
    private String password;
    private Boolean rememberId;

    public LoginForm() {

    }

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getRememberId() {
        return rememberId;
    }

    public void setRememberId(Boolean rememberId) {
        this.rememberId = rememberId;
    }

    public LoginForm(String id, String password, Boolean rememberId) {
        Id = id;
        this.password = password;
        this.rememberId = rememberId;
    }
}
