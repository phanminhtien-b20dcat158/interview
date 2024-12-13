package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.mock.interview_managerment.enums.GenderEnum;
import org.mock.interview_managerment.enums.HighestLevelEnum;
import org.mock.interview_managerment.enums.PositionEnum;
import org.mock.interview_managerment.enums.StatusCandidateEnum;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "candidates")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Candidate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate dob;
    private Integer yearsExperience;
    private String address;
    private String cvAttachmentLink;
    private String email;
    private String name;
    private String note;
    private String phone;
    @ElementCollection
    private List<String> skills;

    @Enumerated(EnumType.STRING)
    private GenderEnum gender;

    @Enumerated(EnumType.STRING)
    private HighestLevelEnum highestLevel;

    @Enumerated(EnumType.STRING)
    private PositionEnum currentPosition;

    @Enumerated(EnumType.STRING)
    private StatusCandidateEnum status;
    @CreatedDate()
    @Column(nullable = false, updatable = false)
    private LocalDate createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDate updatedAt;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "candidate", cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.REMOVE})
    @EqualsAndHashCode.Exclude // không sử dụng trường này trong equals và hashcode
    @ToString.Exclude // Không sử dụng trong toString()
    private List<CandidateJob> candidateJobs;
    private Boolean isDeleted = false;

    /// thêm của Quang
    @OneToMany(mappedBy = "candidate")
    @EqualsAndHashCode.Exclude // không sử dụng trường này trong equals và hashcode
    @ToString.Exclude
    private List<Interview> interviews;
}
