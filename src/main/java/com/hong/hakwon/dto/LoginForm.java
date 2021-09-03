package com.hong.hakwon.dto;

public class LoginForm {
    String Id;
    String password;

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

    public LoginForm(String id, String password) {
        Id = id;
        this.password = password;
    }
}
