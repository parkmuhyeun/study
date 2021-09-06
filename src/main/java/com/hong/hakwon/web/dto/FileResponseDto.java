package com.hong.hakwon.web.dto;

public class FileResponseDto {
    private int id;
    private int post_number;
    private String uuidName;
    private String fileName;

    public FileResponseDto() {
    }

    public int getId() {
        return id;
    }

    public int getPost_number() {
        return post_number;
    }

    public String getUuidName() {
        return uuidName;
    }

    public String getFileName() {
        return fileName;
    }

    public FileResponseDto(int post_number, String uuidName, String fileName) {
        this.post_number = post_number;
        this.uuidName = uuidName;
        this.fileName = fileName;
    }
}
