package com.cinema.advice;

import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cinema.dto.CurrentUserDto;
import com.cinema.models.User;
import com.cinema.repositories.UserRepository;

@ControllerAdvice
public class GlobalModelAttributes {
    private final UserRepository    userRepository;

    public GlobalModelAttributes(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @ModelAttribute
    public void addAttributes(Model model, Authentication authentication) {

        boolean isAdmin = false;

        if (authentication != null) {
            isAdmin = authentication.getAuthorities()
                    .stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
        }

        model.addAttribute("isAdmin", isAdmin);
    }

    @ModelAttribute("currentUser")
    public CurrentUserDto currentUser(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        User user = userRepository.findByUsername(authentication.getName())
            .orElse(null);

        if (user == null) return null;

        return new CurrentUserDto(
            user.getId(),
            user.getUsername(),
            user.getEmail(),
            user.getFirstName(),
            user.getLastName(),
            user.getPhoneNumber(),
            user.getRole().name(),
            user.getCreatedAt()
        );
    }
}
