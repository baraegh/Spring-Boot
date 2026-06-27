package com.cinema.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cinema.models.ChatMessage;
import com.cinema.repositories.ChatMessageRepository;

@Service
public class ChatService {
    private final ChatMessageRepository    chatRepository;

    public ChatService(ChatMessageRepository chatRepository) {
        this.chatRepository = chatRepository;
    }
    
    public ChatMessage save(ChatMessage message) {
        return chatRepository.save(message);
    }

    public Optional<ChatMessage> getById(Long id) {
        return chatRepository.findById(id);
    }

    public List<ChatMessage> getAll() {
        return chatRepository.findAll();
    }

    public List<ChatMessage> getLast20ByFilmId(Long filmId) {
        return chatRepository.findLast20ByFilmId(filmId);
    }

    public ChatMessage update(ChatMessage message) {
        return chatRepository.save(message);
    }

    public void delete(ChatMessage message) {
        chatRepository.delete(message);
    }

    
}
