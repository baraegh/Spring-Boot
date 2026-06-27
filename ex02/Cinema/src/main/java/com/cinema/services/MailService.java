package com.cinema.services;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
    private final JavaMailSender    mailSender;

    @Value("${app.base-url}")
    private String baseUrl;

    public MailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendConfirmationEmail(String to, UUID token) {
        String link = baseUrl + "/confirm?token=" + token.toString();

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject("Confirm your Cinema account");
        message.setText(
            "Welcome to Cinema.\n\n" +
            "Click this link to confirm your account:\n" +
            link
        );

        mailSender.send(message);
    }
}
