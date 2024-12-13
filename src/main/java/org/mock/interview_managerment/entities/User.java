package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mock.interview_managerment.enums.DepartmentEnum;
import org.mock.interview_managerment.enums.GenderEnum;
import org.mock.interview_managerment.enums.StatusUserEnum;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "users")

public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dob;
    private String address;

    @Column(unique = true, nullable = false)
    private String email;
    private String fullName;
    private String note;
    private String password;
    private String phoneNumber;


    private String username;

    @Enumerated(EnumType.STRING)
    private DepartmentEnum department;

    @Enumerated(EnumType.STRING)
    private GenderEnum gender;

    @Enumerated(EnumType.STRING)
    private StatusUserEnum status;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    public String getFullNameWithAccountName() {
        return fullName + " (" + username + ")";
    }

}
