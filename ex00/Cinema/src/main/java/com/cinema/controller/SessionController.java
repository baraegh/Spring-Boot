package com.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cinema.dto.SessionSearchResponse;
import com.cinema.services.SessionService;

@Controller
@RequestMapping("/sessions")
public class SessionController {
    private final SessionService    sessionService;

    public SessionController(SessionService sessionService) {
        this.sessionService = sessionService;
    }

    @GetMapping
    public String get() {
        return "sessions/sessions";
    }

    @GetMapping("/{id}")
    public String getById(@PathVariable Long id, Model model) {
        model.addAttribute("session", sessionService.getById(id).get());
        return "sessions/details";
    }

    @GetMapping("/all")
    @ResponseBody
    public SessionSearchResponse getAllSessions() {
        return sessionService.getAllSessionsDto();
    }

    @GetMapping("/search")
    @ResponseBody
    public SessionSearchResponse searchByFileName(@RequestParam String filmName) {
        return sessionService.searchByFilmName(filmName);
    }    
}
