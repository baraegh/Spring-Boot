package com.cinema.controller;

import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cinema.models.Session;
import com.cinema.services.FilmService;
import com.cinema.services.HallService;
import com.cinema.services.SessionService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequestMapping("/admin/panel/sessions")
public class SessionAdminController {
    private final SessionService    sessionService;
    private final HallService       hallService;
    private final FilmService       filmService;

    public SessionAdminController(SessionService sessionService, HallService hallService, 
            FilmService filmService) {
        this.sessionService = sessionService;
        this.hallService = hallService;
        this.filmService = filmService;
    }

    @PostMapping("/save")
    public String saveSession(
                @RequestParam("filmId") Long filmId, 
                @RequestParam("hallId") Long hallId,
                @RequestParam("dateTime") String dateTime,
                @RequestParam("ticketPrice") double ticketPrice)
    {
        Session session = new Session();
        session.setFilm(filmService.getById(filmId)
            .orElseThrow(() -> new RuntimeException("Film not found"))
        );
        session.setHall(hallService.getById(hallId)
            .orElseThrow(() -> new RuntimeException("Hall not found"))
        );
        session.setDateTime(LocalDateTime.parse(dateTime));
        session.setTicketPrice(ticketPrice);
        sessionService.save(session);
        return "redirect:/admin/panel/sessions";
    }
    
    @GetMapping
    public String getAllSessions(Model model) {
        model.addAttribute("sessions", sessionService.getAll());
        model.addAttribute("halls", hallService.getAll());
        model.addAttribute("films", filmService.getAll());

        return "admin/sessions";
    }
    
}
