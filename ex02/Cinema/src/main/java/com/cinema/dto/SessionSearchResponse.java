package com.cinema.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

public record SessionSearchResponse(
    @JsonProperty("sessions") List<SessionDto>  sessions
) {}
