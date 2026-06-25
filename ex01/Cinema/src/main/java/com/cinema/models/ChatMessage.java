package com.cinema.models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "chat_messages")
public class ChatMessage {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long            id;

    @Column(name = "film_id")
    private Long            filmId;

    @Column(name = "user_id")
    private String          userId;

    @Column(name = "msg")
    private String          msg;

    @Column(name = "date_time")
    private LocalDateTime   dateTime;

    @Transient
    private String          formattedDateTime;

    public ChatMessage() {}

    public ChatMessage(Long id, Long filmId, String userId, String msg, LocalDateTime dateTime, String ipAddress) {
        this.id = id;
        this.filmId = filmId;
        this.userId = userId;
        this.msg = msg;
        this.dateTime = dateTime;
    }

    public ChatMessage(Long filmId, String userId, String msg, LocalDateTime dateTime, String ipAddress) {
        this.filmId = filmId;
        this.userId = userId;
        this.msg = msg;
        this.dateTime = dateTime;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getFilmId() {
        return this.filmId;
    }

    public void setFilmId(Long filmId) {
        this.filmId = filmId;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMsg() {
        return this.msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public LocalDateTime getDateTime() {
        return this.dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public String getFormattedDateTime() {
        if (dateTime == null) return "N/A";
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
