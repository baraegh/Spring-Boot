package com.cinema.services;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cinema.dto.ProfileUpdateDTO;
import com.cinema.models.User;
import com.cinema.models.User.Role;
import com.cinema.repositories.UserRepository;

@Service
public class UserService {
    private final UserRepository    userRepository;
    private final PasswordEncoder   encoder;

    public UserService(UserRepository userRepository, PasswordEncoder   encoder) {
        this.userRepository = userRepository;
        this.encoder = encoder;
    }

    public Optional<User> getById(Long id) {
        return userRepository.findById(id);
    }

    public void save(User user) {
        if (userRepository.findByUsername(user.getUsername()).isPresent() || 
            userRepository.findByEmail(user.getEmail()).isPresent()) {
            throw new IllegalArgumentException("User already exist, username or email already taken");
        }

        user.setPassword(encoder.encode(user.getPassword()));
        user.setRole(Role.USER);
        user.setCreatedAt(LocalDateTime.now());
        userRepository.save(user);
    }

    public void update(User user) {
        if (user.getId() <= 0) {
            throw new IllegalArgumentException("No user found.");
        }

        User existedUser = userRepository.findById(user.getId())
            .orElseThrow(() -> new IllegalArgumentException("No user found."));

        User userToSave = compareChange(user, existedUser);

        userRepository.save(userToSave);
    }

    public void updateProfile(ProfileUpdateDTO dto) {
        if (dto.getId() <= 0) {
            throw new IllegalArgumentException("No user found.");
        }
        User user = new User();
        user.setId(dto.getId());
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEmail(dto.getEmail());
        user.setPhoneNumber(dto.getPhoneNumber());
        update(user);
    }

    private User compareChange(User updatedUser, User existedUser) {

        if (updatedUser.getUsername() != null && !updatedUser.getUsername().isBlank()) {
            existedUser.setUsername(updatedUser.getUsername());
        }

        if (updatedUser.getEmail() != null && !updatedUser.getEmail().isBlank()) {
            existedUser.setEmail(updatedUser.getEmail());
        }

        if (updatedUser.getFirstName() != null && !updatedUser.getFirstName().isBlank()) {
            existedUser.setFirstName(updatedUser.getFirstName());
        }

        if (updatedUser.getLastName() != null && !updatedUser.getLastName().isBlank()) {
            existedUser.setLastName(updatedUser.getLastName());
        }

        if (updatedUser.getPassword() != null && !updatedUser.getPassword().isBlank()) {
            existedUser.setPassword(updatedUser.getPassword());
        }

        if (updatedUser.getRole() != null) {
            existedUser.setRole(updatedUser.getRole());
        }

        if (updatedUser.getTerms() != null) {
            existedUser.setTerms(updatedUser.getTerms());
        }

        return existedUser;
    }
}
