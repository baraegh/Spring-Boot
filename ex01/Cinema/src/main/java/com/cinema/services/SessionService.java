package com.cinema.services;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.cinema.models.Session;
import com.cinema.repositories.SessionRepository;

import com.cinema.dto.SessionSearchResponse;

import com.cinema.dto.SessionDto;
import com.cinema.dto.FilmDto;

@Service
public class SessionService {
    private final SessionRepository  sesssionRepository;

    public SessionService(SessionRepository  sesssionRepository) {
        this.sesssionRepository = sesssionRepository;
    }

    public Session save(Session session) {
        return sesssionRepository.save(session);
    }

    public Optional<Session> getById(Long id) {
        return sesssionRepository.findById(id);
    }

    public List<Session> getAll() {
        return sesssionRepository.findAll();
    }

    public SessionSearchResponse getAllSessionsDto() {
        List<SessionDto> dto = sesssionRepository.findAll().stream()
                .map(this::toSessionDto)
                .collect(Collectors.toList());
        return new SessionSearchResponse(dto);
    }

    public SessionSearchResponse searchByFilmName(String filmName) {
        List<Session> sessions = sesssionRepository.findByFilmTitleContainingIgnoreCase(filmName);

        List<SessionDto> dto = sessions.stream()
            .map(this::toSessionDto)
            .collect(Collectors.toList());
        return new SessionSearchResponse(dto);
    }

    private SessionDto toSessionDto(Session session) {
        FilmDto filmDto = session.getFilm() != null ? 
            new FilmDto(
                session.getFilm().getTitle(),
                session.getFilm().getPosterUrl()
            )
        : null ;

        return new SessionDto(session.getId(), session.getFormattedDateTime(), filmDto, session.getTicketPrice());
    }
}
