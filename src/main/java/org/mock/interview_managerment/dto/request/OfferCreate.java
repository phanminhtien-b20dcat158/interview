package org.mock.interview_managerment.dto.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class OfferCreate {
    private String status;
    private String contractPeriod;
    private String contractType;
    private String level;
    private String department;
    private LocalDate dueDate;
    private double basicSalary;
    private String note;
    private Long candidateId;
    private Long scheduleId;
    private Long recruiterOwnerId;
}
