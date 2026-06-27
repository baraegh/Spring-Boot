package com.cinema.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinema.models.Film;

@Repository
public interface FilmRepository extends JpaRepository<Film, Long> {
    
}
