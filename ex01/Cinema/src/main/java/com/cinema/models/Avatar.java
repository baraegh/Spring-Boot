package com.cinema.models;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "avatars")
public class Avatar {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long    id;

    @Column(name = "user_id")
    private String  userId;

    @Column(name = "film_id")
    private Long    filmId;

    @Column(name = "file_name")
    private String  fileName;

    @Column(name = "original_file_name")
    private String  originalFileName;

    @Column(name = "url")
    private String url;

    @Column(name = "uploaded_at")
    private LocalDateTime uploadedAt;



    public Avatar() {
    }

    public Avatar(Long id, String userId, Long filmId, String fileName, String originalFileName, String url, LocalDateTime uploadedAt) {
        this.id = id;
        this.userId = userId;
        this.filmId = filmId;
        this.fileName = fileName;
        this.originalFileName = originalFileName;
        this.url = url;
        this.uploadedAt = uploadedAt;
    }

    public Avatar(String userId, Long filmId, String fileName, String originalFileName, String url, LocalDateTime uploadedAt) {
        this.userId = userId;
        this.filmId = filmId;
        this.fileName = fileName;
        this.originalFileName = originalFileName;
        this.url = url;
        this.uploadedAt = uploadedAt;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Long getFilmId() {
        return this.filmId;
    }

    public void setFilmId(Long filmId) {
        this.filmId = filmId;
    }

    public String getFileName() {
        return this.fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getOriginalFileName() {
        return this.originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public String getUrl() {
        return this.url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public LocalDateTime getUploadedAt() {
        return this.uploadedAt;
    }

    public void setUploadedAt(LocalDateTime uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
   
}
