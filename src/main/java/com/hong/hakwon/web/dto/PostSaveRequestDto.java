package com.hong.hakwon.web.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class PostSaveRequestDto {
    private String title;
    private MultipartFile file;
    private String content;
    private List<String> hashTagContent;
    private Long category;

    public PostSaveRequestDto() {
    }

    public String getTitle() {
        return title;
    }

    public MultipartFile getFile() {
        return file;
    }

    public String getContent() {
        return content;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getCategory() {
        return category;
    }

    public void setCategory(Long category) {
        this.category = category;
    }

    public List<String> getHashTagContent() {
        return hashTagContent;
    }

    public void setHashTagContent(List<String> hashTagContent) {
        this.hashTagContent = hashTagContent;
    }

    public PostSaveRequestDto(String title, MultipartFile file, String content, List<String> hashTagContent, Long category) {
        this.title = title;
        this.file = file;
        this.content = content;
        this.hashTagContent = hashTagContent;
        this.category = category;
    }
}
