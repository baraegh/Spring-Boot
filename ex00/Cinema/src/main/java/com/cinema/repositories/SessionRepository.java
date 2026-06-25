package com.cinema.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinema.models.Session;

@Repository
public interface SessionRepository extends JpaRepository<Session, Long> {
    List<Session> findByFilmTitleContainingIgnoreCase(String title);
}
