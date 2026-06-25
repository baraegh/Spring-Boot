package com.cinema.validation.validators;

import com.cinema.validation.annotations.ValidPassword;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PasswordValidator implements ConstraintValidator<ValidPassword, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null|| value.isEmpty())
            return false;

        return value.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\\\d).{8,}$");
    }
    
}
