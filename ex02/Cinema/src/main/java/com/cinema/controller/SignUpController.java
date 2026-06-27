package com.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinema.models.User;
import com.cinema.services.MailService;
import com.cinema.services.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/signUp")
public class SignUpController {
    private final UserService       userService;
    private final MailService       mailService;


    public SignUpController(UserService userService, MailService mailService) {
        this.userService = userService;
        this.mailService = mailService;
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
            mailService.sendConfirmationEmail(user.getEmail(), user.getVerificationToken());
            return "redirect:/login";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "signUp";
        }
    }
}
