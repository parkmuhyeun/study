package com.hong.hakwon.Beans;

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

    public int getSigungu_cd() {
        return sigungu_cd;
    }

    public SiGunGu() {
    }
    public String getSigungu_name() {
        return sigungu_name;
    }
}
