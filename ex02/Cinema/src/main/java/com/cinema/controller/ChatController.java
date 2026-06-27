package com.cinema.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cinema.models.ChatMessage;
import com.cinema.services.AvatarService;
import com.cinema.services.ChatService;
import com.cinema.services.FilmService;

@Controller
@RequestMapping("/films")
public class ChatController {

    private final ChatService chatService;
    private final FilmService filmService;
    private final SimpMessagingTemplate messagingTemplate;
    private final AvatarService avatarService;

    public ChatController(ChatService chatService,
                          FilmService filmService,
                          SimpMessagingTemplate messagingTemplate,
                          AvatarService avatarService) {
        this.chatService = chatService;
        this.filmService = filmService;
        this.messagingTemplate = messagingTemplate;
        this.avatarService = avatarService;
    }

    @MessageMapping("/films/{filmId}/chat")
    public void sendToFilmRoom(@Payload ChatMessage message,
                               @DestinationVariable long filmId,
                               Principal principal) {

        String username = principal != null ? principal.getName() : "Anonymous";

        message.setFilmId(filmId);
        message.setUserId(username);

        if (message.getDateTime() == null) {
            message.setDateTime(LocalDateTime.now());
        }

        ChatMessage savedMessage = chatService.save(message);

        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("id", savedMessage.getId());
        payload.put("filmId", savedMessage.getFilmId());
        payload.put("userId", savedMessage.getUserId());
        payload.put("msg", savedMessage.getMsg());
        payload.put("dateTime", savedMessage.getDateTime().toString());
        payload.put("formattedDateTime", savedMessage.getFormattedDateTime());

        messagingTemplate.convertAndSend(
            "/topic/films/" + filmId + "/chat",
            (Object) payload
        );
    }

    @GetMapping("/{filmId}/chat")
    public String getChatPage(@PathVariable long filmId,
                              Model model,
                              Authentication authentication) {

        String username = authentication.getName();

        model.addAttribute("filmId", filmId);
        model.addAttribute("film", filmService.getById(filmId).orElseThrow());
        model.addAttribute("initialMessages", chatService.getLast20ByFilmId(filmId).reversed());
        model.addAttribute("avatars", avatarService.getByUserIdAndFilmId(username, filmId));
        model.addAttribute("chatUserId", username);

        return "films/chat";
    }

    @GetMapping("/{filmId}/messages")
    @ResponseBody
    public List<ChatMessage> getMessages(@PathVariable long filmId) {
        return chatService.getLast20ByFilmId(filmId);
    }
}