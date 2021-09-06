package com.hong.hakwon.web.dto;

public class PostListResponseDto {

    private int id;
    private String title;
    private Long createdDate;
    private String creator;

    public PostListResponseDto() {
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public Long getCreatedDate() {
        return createdDate;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCreator() {
        return creator;
    }

    public PostListResponseDto(int id, String title, Long createdDate, String creator) {
        this.id = id;
        this.title = title;
        this.createdDate = createdDate;
        this.creator = creator;
    }
}
