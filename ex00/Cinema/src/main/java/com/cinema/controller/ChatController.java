package com.cinema.controller;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cinema.models.ChatMessage;
import com.cinema.models.UserAuthentication;
import com.cinema.repositories.AuthRepository;
import com.cinema.services.AvatarService;
import com.cinema.services.ChatService;
import com.cinema.services.FilmService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/films")
public class ChatController {
    private final ChatService           chatService;
    private final AuthRepository        authRepository;
    private final FilmService           filmService;
    private final SimpMessagingTemplate messagingTemplate;
    private final AvatarService         avatarService;

    public ChatController(ChatService chatService,
            AuthRepository authRepository,
            FilmService filmService,
            SimpMessagingTemplate messagingTemplate,
            AvatarService avatarService) {
        this.chatService = chatService;
        this.authRepository = authRepository;
        this.filmService = filmService;
        this.messagingTemplate = messagingTemplate;
        this.avatarService = avatarService;
    }

    @MessageMapping("/films/{filmId}/chat")
    public void sendToFilmRoom(@Payload ChatMessage message, @DestinationVariable long filmId) {
        message.setFilmId(filmId);
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

        messagingTemplate.convertAndSend("/topic/films/" + filmId + "/chat", (Object) payload);
    }

    @GetMapping("/{filmId}/chat")
    public String getChatPage(@PathVariable long filmId,
            Model model,
            HttpServletRequest  request,
            @CookieValue(value = "userId", required = false) String  userId
        ) {
        UserAuthentication auth = new UserAuthentication(
            null,
            userId,
            request.getRemoteAddr(),
            LocalDateTime.now(),
            filmId
        );
        authRepository.save(auth);

        model.addAttribute("filmId", filmId);
        model.addAttribute("film", filmService.getById(filmId));
        model.addAttribute("initialMessages", chatService.getLast20ByFilmId(filmId));
        model.addAttribute("userAuthentication", authRepository.findByUserId(userId));
        model.addAttribute("avatars", avatarService.getByUserIdAndFilmId(userId, filmId));
        return "films/chat";
    }

    @GetMapping("/{filmId}/messages")
    @ResponseBody
    public List<ChatMessage> getMessages(@PathVariable long filmId) {
        return chatService.getLast20ByFilmId(filmId);
    }
}
