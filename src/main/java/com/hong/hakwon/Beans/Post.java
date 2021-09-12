package com.hong.hakwon.Beans;

public class Post {

    private int id;
    private String title;
    private String content;
    private String filePath;
    private String createdDate;
    private String creator;
    private String modifiedDate;
    private String modifier;
    private Long views;
    private Long category;

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

    public String getCreatedDate() {
        return createdDate;
    }

    public String getModifiedDate() {
        return modifiedDate;
    }

    public String getCreator() {
        return creator;
    }

    public String getModifier() {
        return modifier;
    }

    public Long getViews() {
        return views;
    }

    public Long getCategory() {
        return category;
    }

    public Post(String title, String content, String filePath, String creator, String modifier, Long category) {
        this.title = title;
        this.content = content;
        this.filePath = filePath;
        this.creator = creator;
        this.modifier = modifier;
        this.category = category;
    }
}
