package com.hong.hakwon.web.dto;

public class SiGunGu {

    private int sido_cd;
    private int sigungu_cd;
    private String sigungu_name;

    public SiGunGu(int sido_cd, int sigungu_cd, String sigungu_name) {
        this.sido_cd = sido_cd;
        this.sigungu_cd = sigungu_cd;
        this.sigungu_name = sigungu_name;
    }

    public int getSido_cd() {
        return sido_cd;
    }

    public void setSido_cd(int sido_cd) {
        this.sido_cd = sido_cd;
    }

    public int getSigungu_cd() {
        return sigungu_cd;
    }

    public SiGunGu() {
    }

    public void setSigungu_cd(int sigungu_cd) {
        this.sigungu_cd = sigungu_cd;
    }

    public String getSigungu_name() {
        return sigungu_name;
    }

    public void setSigungu_name(String sigungu_name) {
        this.sigungu_name = sigungu_name;
    }
}
