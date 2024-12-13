package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.mock.interview_managerment.enums.StatusJobEnum;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;

@Data
@Entity
@Table(name = "jobs")
@EntityListeners(AuditingEntityListener.class)
public class Job {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long jobId;

    private String title;
    private String description;
    private String requiredSkills;
    private String level;
    private Timestamp startDate;
    private Timestamp endDate;
    private String location;
    private String benefits;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private StatusJobEnum status;

    private String salaryFrom;
    private String salaryTo;
    private Boolean isDeleted = false;
    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;
    private String lastModifiedBy;

    public LocalDate getStartDateAsLocalDate() {
        return startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

    public LocalDate getEndDateAsLocalDate() {
        return endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

}
