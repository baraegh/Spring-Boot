package com.cinema.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "films")
public class Film {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) 
    @Column(name = "id")
    private Long    id;

    @Column(name= "title")
    private String  title;

    @Column(name = "year")
    private String  year;

    @Column(name = "age_restrictions")
    private int     ageRestrictions;

    @Column(name = "description")
    private String  description;

    @Column(name = "poster_url")
    private String  posterUrl;

    public Film() {}

    public Film(Long id, String title, String year, int ageRestrictions, String description, String posterUrl) {
        this.id = id;
        this.title = title;
        this.year = year;
        this.ageRestrictions = ageRestrictions;
        this.description = description;
        this.posterUrl = posterUrl;
    }

    public Film(String title, String year, int ageRestrictions, String description, String posterUrl) {
        this.title = title;
        this.year = year;
        this.ageRestrictions = ageRestrictions;
        this.description = description;
        this.posterUrl = posterUrl;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public int getAgeRestrictions() {
        return ageRestrictions;
    }

    public void setAgeRestrictions(int ageRestrictions) {
        this.ageRestrictions = ageRestrictions;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }
}
