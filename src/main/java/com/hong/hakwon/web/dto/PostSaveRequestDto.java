package com.hong.hakwon.web.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class PostSaveRequestDto {
    private String title;
    private MultipartFile file;
    private String content;
    private List<String> hashTagContent;

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

    public List<String> getHashTagContent() {
        return hashTagContent;
    }

    public void setHashTagContent(List<String> hashTagContent) {
        this.hashTagContent = hashTagContent;
    }

    public PostSaveRequestDto(String title, MultipartFile file, String content, List<String> hashTagContent) {
        this.title = title;
        this.file = file;
        this.content = content;
        this.hashTagContent = hashTagContent;
    }
}
