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
@Table(name = "user_authentication")
public class UserAuthentication {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long            id;

    @Column(name = "user_id")
    private String          userId;

    @Column(name = "ip_adress")
    private String          ipAdress;

    @Column(name = "date_time")
    private LocalDateTime   dateTime;
    
    @Transient
    private String          formattedDateTime;

    @Column(name = "film_id")
    private Long            filmId;


    public UserAuthentication() {}

    public UserAuthentication(Long id, String userId, String ipAdress, LocalDateTime dateTime, Long filmId) {
        this.id = id;
        this.userId = userId;
        this.ipAdress = ipAdress;
        this.dateTime = dateTime;
        this.filmId = filmId;
    }

    public UserAuthentication(String userId, String ipAdress, LocalDateTime dateTime, Long filmId) {
        this.userId = userId;
        this.ipAdress = ipAdress;
        this.dateTime = dateTime;
        this.filmId = filmId;
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

    public String getIpAdress() {
        return this.ipAdress;
    }

    public void setIpAdress(String ipAdress) {
        this.ipAdress = ipAdress;
    }

    public LocalDateTime getDateTime() {
        return this.dateTime;
    }

    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }

    public Long getFilmId() {
        return this.filmId;
    }

    public void setFilmId(Long filmId) {
        this.filmId = filmId;
    }

    public String getFormattedDateTime() {
        if (dateTime == null) return "N/A";
        return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
