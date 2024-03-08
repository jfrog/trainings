package org.yann.demo.model;

public class Image {
    private String name;
    private String comment;

    public Image(String name, String comment) {
        this.name = name;
        this.comment = comment;
    }

    public String GetName() {
        return this.name;
    }

    public String GetComment() {
        return this.comment;
    }
}

