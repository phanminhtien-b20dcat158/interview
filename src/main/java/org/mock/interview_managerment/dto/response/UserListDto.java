package org.mock.interview_managerment.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserListDto {

    private Long userId;

    private String username;

    private String email;

    private String phoneNumber;

    private String role;

    private String status;
}
