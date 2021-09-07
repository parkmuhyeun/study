package com.hong.hakwon.web.dto;

public class PostResponseDto {

    private int id;
    private String title;
    private String content;
    private String filePath;
    private String createdDate;
    private String creator;
    private String modifiedDate;
    private String modifier;

    public PostResponseDto() {
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public String getFilePath() {
        return filePath;
    }

    public String getCreator() {
        return creator;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(String modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getModifier() {
        return modifier;
    }

    public PostResponseDto(int id, String title, String content, String filePath, String createdDate, String creator, String modifiedDate, String modifier) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.filePath = filePath;
        this.createdDate = createdDate;
        this.creator = creator;
        this.modifiedDate = modifiedDate;
        this.modifier = modifier;
    }
}
