package com.hong.hakwon.web.dto;

public class PostListResponseDto {

    private int id;
    private String title;
    private String createdDate;
    private String creator;

    public PostListResponseDto() {
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCreator() {
        return creator;
    }

    public PostListResponseDto(int id, String title, String createdDate, String creator) {
        this.id = id;
        this.title = title;
        this.createdDate = createdDate;
        this.creator = creator;
    }
}
