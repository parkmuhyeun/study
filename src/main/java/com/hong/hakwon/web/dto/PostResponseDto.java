package com.hong.hakwon.web.dto;

public class PostResponseDto {

    private int id;
    private String title;
    private String content;
    private String filePath;
    private Long createdDate;
    private String creator;
    private Long modifiedDate;
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

    public Long getCreatedDate() {
        return createdDate;
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

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public Long getModifiedDate() {
        return modifiedDate;
    }

    public String getModifier() {
        return modifier;
    }

    public PostResponseDto(int id, String title, String content, String filePath, Long createdDate, String creator, Long modifiedDate, String modifier) {
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
