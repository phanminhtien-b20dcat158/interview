package org.mock.interview_managerment.dto.request;

import jakarta.persistence.ElementCollection;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.GenderEnum;
import org.mock.interview_managerment.enums.HighestLevelEnum;
import org.mock.interview_managerment.enums.PositionEnum;
import org.mock.interview_managerment.enums.StatusCandidateEnum;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Getter
@Setter
public class CandidateCreateDto {
    private Long id;
    @NotBlank(message = "Required field")
    private String name;

    @NotBlank(message = "Required field")
    @Email(message = "Email must be valid")
    private String email;


    private String phone;

    @NotNull(message = "Required field")
    private StatusCandidateEnum status;

    @NotNull(message = "Required field")
    private PositionEnum currentPosition;

    private String cvAttachmentLink;

    @Size(min = 1, message = "Please choose one skill")
    @ElementCollection
    private List<@NotNull(message = "Skill cannot be blank") String> skills;


    @Positive(message = "Years of experience must be positive")
    private int yearsExperience;

    @NotNull(message = "Required field")
    private HighestLevelEnum highestLevel;

    @NotNull(message = "Required field")
    @PastOrPresent(message = "Date of Birth must be in the past")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dob;

    private String note;


    private String address;

    @NotNull(message = "Required field")
    private GenderEnum gender;

    @NotNull(message = "Required field")
    private User user;
}
