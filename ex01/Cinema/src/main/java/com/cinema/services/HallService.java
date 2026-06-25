package com.cinema.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cinema.models.Hall;
import com.cinema.repositories.HallRepository;

@Service
public class HallService {
    private final HallRepository hallRepository;

    public HallService(HallRepository hallRepository) {
        this.hallRepository = hallRepository;
    }

    public Hall save(Hall hall) {
        return hallRepository.save(hall);
    }

    public Optional<Hall> getById(Long id) {
        return hallRepository.findById(id);
    }

    public List<Hall> getAll() {
        return hallRepository.findAll();
    }
}
