package com.hong.hakwon.web.dto;

import java.util.List;

public class PostListResponseDto {

    private int id;
    private String title;
    private String createdDate;
    private String creator;
    private List<List<String>> tag;

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

    public List<List<String>> getTag() {
        return tag;
    }

    public void setTag(List<List<String>> tag) {
        this.tag = tag;
    }

    public PostListResponseDto(int id, String title, String createdDate, String creator, List<List<String>> tag) {
        this.id = id;
        this.title = title;
        this.createdDate = createdDate;
        this.creator = creator;
        this.tag = tag;
    }
}
