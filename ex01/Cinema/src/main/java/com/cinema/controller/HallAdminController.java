package com.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinema.models.Hall;
import com.cinema.services.HallService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
@RequestMapping("/admin/panel/halls")
public class HallAdminController {
    
    private final HallService   hallService;

    public HallAdminController(HallService hallService) {
        this.hallService = hallService;
    }

    @PostMapping("/save")
    public String saveHall(@ModelAttribute Hall hall) {
        hallService.save(hall);
        return "redirect:/admin/panel/halls";
    }
    
    @GetMapping
    public String getAllHalls(Model model) {
        model.addAttribute("halls", hallService.getAll());

        return "admin/halls";
    }
    
}
