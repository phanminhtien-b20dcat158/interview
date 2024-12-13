package org.mock.interview_managerment.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = FullNameValidator.class)
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface FullNameChecked {
    String message() default "Full name must have at least 2 words";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}