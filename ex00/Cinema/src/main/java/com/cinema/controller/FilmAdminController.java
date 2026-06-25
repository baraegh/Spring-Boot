package com.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cinema.models.Film;
import com.cinema.services.FilmService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequestMapping("/admin/panel/films")
public class FilmAdminController {
    
    private final FilmService   filmService;

    public FilmAdminController(FilmService filmService) {
        this.filmService = filmService;
    }

    @PostMapping("/save")
    public String saveFilm(@ModelAttribute Film film,
            @RequestParam("poster") MultipartFile poster) {
        filmService.save(film, poster);
        return "redirect:/admin/panel/films";
    }
    

    @GetMapping
    public String getAllFilms(Model model) {
        model.addAttribute("films", filmService.getAll());

        return "admin/films";
    }
    
}
