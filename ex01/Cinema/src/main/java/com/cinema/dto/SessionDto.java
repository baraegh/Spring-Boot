package com.cinema.dto;

public record SessionDto(
    Long    id,
    String  dateTime,
    FilmDto film,
    double  ticketPrice
) {}
