package com.hong.hakwon.dto;

public class SiDo {
    private int sido_cd;
    private String sido_name;


    public int getSido_cd() {
        return sido_cd;
    }

    public void setSido_cd(int sido_cd) {
        this.sido_cd = sido_cd;
    }

    public String getSido_name() {
        return sido_name;
    }

    public void setSido_name(String sido_name) {
        this.sido_name = sido_name;
    }

    public SiDo() {
    }

    public SiDo(int sido_cd, String sido_name) {
        this.sido_cd = sido_cd;
        this.sido_name = sido_name;
    }
}
