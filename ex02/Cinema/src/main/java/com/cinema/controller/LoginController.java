package com.cinema.controller;

import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cinema.exception.InvalidVerificationTokenException;
import com.cinema.services.UserService;

@Controller
public class LoginController {
    private final UserService   userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/confirm")
    public String activateAccount(@RequestParam UUID token) {
        try {
            userService.activateAccount(token);
            return "redirect:/login?confirmed=true";
        } catch (InvalidVerificationTokenException e) {
            return "redirect:/login?invalid_token=true";
        }
    }
}
