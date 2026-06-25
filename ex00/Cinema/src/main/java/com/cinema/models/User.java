package com.cinema.models;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long            id;

    @Column(unique = true)
    private String          username;
    
    @Column
    private String          password;

    @Column
    private String          email;

    @Column
    private String          firstName;

    @Column
    private String          lastName;

    @Column
    @Enumerated(EnumType.STRING)
    private Role            role;

    @Column
    private Boolean         terms;

    @Column
    private LocalDateTime   createdAt;

    // TODO: user profile image -- to be implemented

    public enum Role {
        ADMIN,
        USER
    }

    public User() {}


    public User(Long id, String username, String password, String email, String firstName, String lastName, LocalDateTime createdAt) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.createdAt = createdAt;
    }

    public User(String username, String password, String email, String firstName, String lastName, LocalDateTime createdAt) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.createdAt = createdAt;
    }
   

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return this.firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Role getRole() {
        return this.role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Boolean getTerms() {
        return this.terms;
    }

    public void setTerms(Boolean terms) {
        this.terms = terms;
    }

}
