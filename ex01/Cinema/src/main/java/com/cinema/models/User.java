package com.cinema.models;

import java.time.LocalDateTime;

import com.cinema.validation.annotations.ValidPassword;
import com.cinema.validation.annotations.ValidPhoneNumber;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "users")
public class User {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    private Long            id;

    @NotBlank(message = "{user.username.required}")
    @Column(unique = true, nullable = false)
    private String          username;
    

    @ValidPassword(message = "{user.password.invalid}")
    @Column(nullable = false)
    private String          password;

    @Email(message = "{user.email.invalid}")
    @NotBlank(message = "{user.email.required}")
    @Column(nullable = false)
    private String          email;

    @NotBlank(message = "{user.firstname.required}")
    @Column
    private String          firstName;

    @NotBlank(message = "{user.lastname.required}")
    @Column
    private String          lastName;

    @ValidPhoneNumber(message = "{user.phone.invalid}")
    @NotBlank(message = "{user.phone.required}")
    @Column
    private String          phoneNumber;

    @Column
    @Enumerated(EnumType.STRING)
    private Role            role;

    @AssertTrue(message = "{user.terms.required}")
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

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Boolean isTerms() {
        return this.terms;
    }

}
