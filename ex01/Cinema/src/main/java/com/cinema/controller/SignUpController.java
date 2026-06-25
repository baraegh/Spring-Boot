package com.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinema.models.User;
import com.cinema.services.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/signUp")
public class SignUpController {
    private final UserService       userService;

    public SignUpController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping
    public String getSignUpPage() {
        return "signUp";
    }

    @PostMapping
    public String signUp(@Valid @ModelAttribute User user, BindingResult result, Model model) {
        if (result.hasErrors()) {
            
            result.getAllErrors().forEach(e ->
                System.out.println("[" + e.getDefaultMessage() + "]"));

            model.addAttribute("errors", result.getAllErrors());
            return "signUp";
        }

        try {
            userService.save(user);
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "signUp";
        }
    }
}
