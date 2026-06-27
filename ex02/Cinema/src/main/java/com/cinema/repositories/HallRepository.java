package com.cinema.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinema.models.Hall;

@Repository
public interface HallRepository extends JpaRepository<Hall, Long> {
    
}
