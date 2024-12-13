package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mock.interview_managerment.enums.*;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "offers")
public class Offer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long offerId;

    @NotNull
    private Double basicSalary;
    @NotNull
    private Date dueDate;
    @NotNull
    private Date endContract;
    @NotNull
    private Date startContract;
    private String note;
    private boolean deleted = false;  // Add this line

    @Enumerated(EnumType.STRING)
    @NotNull
    private ContractTypeEnum contractType;

    @Enumerated(EnumType.STRING)
    @NotNull
    private DepartmentEnum department;

    @Enumerated(EnumType.STRING)
    @NotNull
    private LevelEnum level;

    @Enumerated(EnumType.STRING)
    @NotNull
    private PositionEnum position;

    @Enumerated(EnumType.STRING)
    private OfferStatusEnum status;

    @ManyToOne
    @JoinColumn(name = "approver_id")
    @NotNull
    private User approver;

    @ManyToOne
    @JoinColumn(name = "interview_id")
    private Interview interview;

    @ManyToOne
    @JoinColumn(name = "candidate_id")
    @NotNull
    private Candidate candidate;

    @ManyToOne
    @JoinColumn(name = "recruiter_id")
    @NotNull
    private User recruiter;

    @CreatedDate()
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false, updatable = false, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

}
