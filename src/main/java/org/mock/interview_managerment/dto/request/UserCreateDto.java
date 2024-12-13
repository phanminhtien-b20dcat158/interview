package org.mock.interview_managerment.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mock.interview_managerment.entities.Role;
import org.mock.interview_managerment.enums.DepartmentEnum;
import org.mock.interview_managerment.enums.GenderEnum;
import org.mock.interview_managerment.enums.StatusUserEnum;
import org.mock.interview_managerment.validator.FullNameChecked;
import org.mock.interview_managerment.validator.PhoneNumberChecked;
import org.mock.interview_managerment.validator.UniqueEmail;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserCreateDto {


    @FullNameChecked
    private String fullName;

    @NotNull(message = "Email cannot be null")
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    @UniqueEmail
    private String email;

    @NotNull(message = "Phone number can not be null")
    @PhoneNumberChecked
    private String phoneNumber;

    @NotNull(message = "Date of birth is required")
    @Past(message = "Date of birth must be in the past")
    private LocalDate dob;
    private String address;
    private String note;
    private DepartmentEnum department;
    private GenderEnum gender;
    private StatusUserEnum status;
    private Role role;
}
