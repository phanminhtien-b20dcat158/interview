package org.mock.interview_managerment.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PhoneNumberValidator implements ConstraintValidator<PhoneNumberChecked, String> {

    @Override
    public void initialize(PhoneNumberChecked constraintAnnotation) {
    }

    @Override
    public boolean isValid(String phoneNumber, ConstraintValidatorContext context) {
        // Kiểm tra nếu số điện thoại không được để trống và chỉ chứa số
        return phoneNumber != null && phoneNumber.matches("\\d+");
    }
}