package com.hong.hakwon.Beans;

public class Post {

    private int id;
    private String title;
    private String content;
    private String filePath;
    private Long createdDate;
    private String creator;
    private Long modifiedDate;
    private String modifier;

    public Post() {
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

    public Long getCreatedDate() {
        return createdDate;
    }

    public Long getModifiedDate() {
        return modifiedDate;
    }

    public String getCreator() {
        return creator;
    }

    public String getModifier() {
        return modifier;
    }

    public Post(String title, String content, String filePath, Long createdDate, String creator, Long modifiedDate, String modifier) {
        this.title = title;
        this.content = content;
        this.filePath = filePath;
        this.createdDate = createdDate;
        this.creator = creator;
        this.modifiedDate = modifiedDate;
        this.modifier = modifier;
    }

    public Post(String title, String content, String filePath, String creator, Long modifiedDate, String modifier) {
        this.title = title;
        this.content = content;
        this.filePath = filePath;
        this.creator = creator;
        this.modifiedDate = modifiedDate;
        this.modifier = modifier;
    }
}
