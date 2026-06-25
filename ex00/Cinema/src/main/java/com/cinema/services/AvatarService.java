package com.cinema.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cinema.models.Avatar;
import com.cinema.repositories.AvatarRepository;

import jakarta.servlet.ServletContext;

@Service
public class AvatarService {
    public  final AvatarRepository      avatarRepository;
    private final ServletContext        servletContext;

    public AvatarService(AvatarRepository avatarRepository, ServletContext servletContext) {
        this.avatarRepository = avatarRepository;
        this.servletContext = servletContext;
    }

    public Avatar save(MultipartFile image, String userId, Long filmId) throws IOException {
        String  uploadDir = servletContext.getRealPath("/static/uploads/avatars/");
        Path    uploadPath = Paths.get(uploadDir);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String originalName = image.getOriginalFilename();
        String extension = originalName.substring(originalName.lastIndexOf('.'));
        String uniqueName = UUID.randomUUID().toString() + extension;

        Path filePath = uploadPath.resolve(uniqueName);
        Files.copy(image.getInputStream(), filePath,
                StandardCopyOption.REPLACE_EXISTING);

        Avatar avatar = new Avatar(
            userId,
            filmId,
            originalName,
            uniqueName,
            "/cinema/static/uploads/avatars/" + uniqueName,
            LocalDateTime.now()
        );

        return avatarRepository.save(avatar);
    }

    public List<Avatar> getByUserIdAndFilmId(String userId, Long filmId) {
        return avatarRepository.findByUserIdAndFilmId(userId, filmId);
    }
}
