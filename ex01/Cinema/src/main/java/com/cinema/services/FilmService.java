package com.cinema.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cinema.models.Film;
import com.cinema.repositories.FilmRepository;

import jakarta.servlet.ServletContext;

@Service
public class FilmService {
    private final FilmRepository filmRepository;
    private final ServletContext servletContext;

    public FilmService(FilmRepository filmRepository, ServletContext servletContext) {
        this.filmRepository = filmRepository;
        this.servletContext = servletContext;
    }

    public Film save(Film film, MultipartFile poster) {
        if (!poster.isEmpty()) {
           
            String uploadDir = servletContext.getRealPath("/static/uploads/");
            Path uploadPath = Paths.get(uploadDir);
            if (!Files.exists(uploadPath)) {
                try {
                    Files.createDirectories(uploadPath);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            String fileName = poster.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);
            try {
                Files.copy(poster.getInputStream(), filePath,
                        StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                e.printStackTrace();
            }

            film.setPosterUrl("/cinema/static/uploads/" + fileName);
        }

        return filmRepository.save(film);
    }

    public Optional<Film> getById(Long id) {
        return filmRepository.findById(id);
    }

    public List<Film> getAll() {
        return filmRepository.findAll();
    }
}
