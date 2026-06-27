package com.cinema.exception;

public class InvalidVerificationTokenException extends RuntimeException {

    public InvalidVerificationTokenException() {
        super("Invalid verification token.");
    }

    public InvalidVerificationTokenException(String message) {
        super(message);
    }
}