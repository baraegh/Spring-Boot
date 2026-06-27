package com.cinema.validation.validators;

import com.cinema.validation.annotations.ValidPhoneNumber;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PhoneNumberValidator implements ConstraintValidator<ValidPhoneNumber, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null|| value.isEmpty())
            return false;

        return value.matches("^\\+\\d\\(\\d{3}\\)\\d{6}$");
    }
    
}
