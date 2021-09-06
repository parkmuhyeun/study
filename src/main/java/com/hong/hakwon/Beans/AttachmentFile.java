package com.hong.hakwon.Beans;

public class AttachmentFile {

    private int id;
    private int postNumber;
    private String uuidName;
    private String fileName;
    private String createdDate;
    private String creator;
    private String modifiedDate;
    private String modifier;

    public AttachmentFile() {
    }


    public int getId() {
        return id;
    }

    public int getPostNumber() {
        return postNumber;
    }

    public String getUuidName() {
        return uuidName;
    }

    public String getFileName() {
        return fileName;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public String getCreator() {
        return creator;
    }

    public String getModifiedDate() {
        return modifiedDate;
    }

    public String getModifier() {
        return modifier;
    }

    public AttachmentFile(int postNumber, String uuidName, String fileName, String createdDate, String creator, String modifiedDate, String modifier) {
        this.postNumber = postNumber;
        this.uuidName = uuidName;
        this.fileName = fileName;
        this.createdDate = createdDate;
        this.creator = creator;
        this.modifiedDate = modifiedDate;
        this.modifier = modifier;
    }
}
