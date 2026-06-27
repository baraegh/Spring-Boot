package com.cinema.dto;

import com.cinema.validation.annotations.ValidPhoneNumber;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public class ProfileUpdateDTO {
    private Long            id;

    @Email(message = "Email should respect it's format")
    @NotBlank(message = "Email is required")
    private String          email;

    @NotBlank(message = "Firstname is required")
    private String          firstName;

    @NotBlank(message = "Lastname is required")
    private String          lastName;

    @ValidPhoneNumber(message = "Phone number must be in format +7(777)777777")
    @NotBlank(message = "Phone number is required")
    private String          phoneNumber;
 

    public ProfileUpdateDTO() {
    }


    public ProfileUpdateDTO(Long id, String email, String firstName, String lastName, String phoneNumber) {
        this.id = id;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phoneNumber = phoneNumber;
    }


    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    
}
