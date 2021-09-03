package com.hong.hakwon.web.dto;

public class UserSaveDto {

    private String userId;
    private String password;
    private String name;
    private String f_number;
    private String m_number;
    private String e_number;
    private String sido;
    private String sigungu;
    private String email;

    public UserSaveDto() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getF_number() {
        return f_number;
    }

    public void setF_number(String f_number) {
        this.f_number = f_number;
    }

    public String getM_number() {
        return m_number;
    }

    public void setM_number(String m_number) {
        this.m_number = m_number;
    }

    public String getE_number() {
        return e_number;
    }

    public void setE_number(String e_number) {
        this.e_number = e_number;
    }

    public String getSido() {
        return sido;
    }

    public void setSido(String sido) {
        this.sido = sido;
    }

    public String getSigungu() {
        return sigungu;
    }

    public void setSigungu(String sigungu) {
        this.sigungu = sigungu;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public UserSaveDto(String userId, String password, String name, String f_number, String m_number, String e_number, String sido, String sigungu, String email) {
        this.userId = userId;
        this.password = password;
        this.name = name;
        this.f_number = f_number;
        this.m_number = m_number;
        this.e_number = e_number;
        this.sido = sido;
        this.sigungu = sigungu;
        this.email = email;
    }
}
