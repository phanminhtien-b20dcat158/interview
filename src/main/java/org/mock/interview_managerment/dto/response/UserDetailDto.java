package org.mock.interview_managerment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDetailDto {

    private Long userId;
    private String fullName;
    private LocalDate dob;
    private String phoneNumber;
    private String role;
    private String status;
    private String email;
    private String address;
    private String gender;
    private String department;
    private String note;
}
