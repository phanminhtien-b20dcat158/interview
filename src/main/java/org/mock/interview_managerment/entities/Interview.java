package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import org.mock.interview_managerment.enums.ResultInterviewEnum;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Data
@Entity
@Table(name = "interviews")
public class Interview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long interviewId;

    @NotNull(message = "Please enter date.")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    @DateTimeFormat(pattern = "HH:mm")
    @NotNull(message = "Please enter start time.")
    private LocalTime startTime;

    @DateTimeFormat(pattern = "HH:mm")
    @NotNull(message = "Please enter end time.")
    private LocalTime endTime;

    private String location;
    private String meetingId;
    private String note;

    @NotBlank(message = "Please enter title.")
    private String title;

    private boolean deleted = false;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private ResultInterviewEnum result;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private StatusInterviewEnum status;

    @NotNull(message = "Mandatory")
    @ManyToOne
    @JoinColumn(name = "recruiter_id")
    private User recruiter;

    @NotNull(message = "Mandatory")
    @ManyToOne
    @JoinColumn(name = "job_id")
    private Job job;

    @NotNull(message = "Mandatory")
    @ManyToOne
    @JoinColumn(name = "candidate_id")
    private Candidate candidate;


    @OneToMany(mappedBy = "interview", cascade = CascadeType.ALL)
    @EqualsAndHashCode.Exclude // không sử dụng trường này trong equals và hashcode
    @ToString.Exclude // Không sử dụng trong toString()
    private List<ScheduledInterview> scheduledInterviews;

    @Transient // Chú thích này để JPA không lưu trữ trường này vào cơ sở dữ liệu
    private List<Long> selectedInterviewerIds;




}
