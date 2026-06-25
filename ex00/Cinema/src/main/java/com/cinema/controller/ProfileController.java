package com.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinema.models.User;
import com.cinema.services.UserService;

@Controller
@RequestMapping("/profile")
public class ProfileController {
    private final UserService   userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String getprofile(Model model) {
        return "user/profile";
    }

    @PostMapping("/save")
    public String saveProfile(@ModelAttribute User user) {
        userService.update(user);

        return "redirect:/profile";
    }
}
