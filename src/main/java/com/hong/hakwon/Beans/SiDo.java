package com.hong.hakwon.Beans;

public class SiDo {
    private int sido_cd;
    private String sido_name;


    public int getSido_cd() {
        return sido_cd;
    }


    public String getSido_name() {
        return sido_name;
    }

    public SiDo() {
    }

    public SiDo(int sido_cd, String sido_name) {
        this.sido_cd = sido_cd;
        this.sido_name = sido_name;
    }
}
