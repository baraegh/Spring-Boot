package com.cinema.controller;

import java.io.IOException; 

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cinema.services.AvatarService;

@Controller
@RequestMapping("/avatar")
public class AvatarController {
    private final AvatarService avatarService;

    public AvatarController(AvatarService avatarService) {
        this.avatarService = avatarService;
    }

    @PostMapping("/{userId}/{filmId}")
    public String save(@RequestParam MultipartFile image, @PathVariable String userId,
            @PathVariable Long filmId) throws IOException {
        avatarService.save(image, userId, filmId);
        return "redirect:/films/" + filmId + "/chat";
    }
}
