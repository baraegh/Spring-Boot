package com.cinema.dto;

import java.time.LocalDateTime;

public record CurrentUserDto(
    Long id,
    String username,
    String email,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
    LocalDateTime createdAt
) {}