package org.mock.interview_managerment.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class FullNameValidator implements ConstraintValidator<FullNameChecked, String> {
    @Override
    public boolean isValid(String fullName, ConstraintValidatorContext context) {
        if (fullName == null || fullName.trim().isEmpty()) {
            return false;
        }

        String[] words = fullName.trim().split("\\s+");
        return words.length >= 2;
    }
}