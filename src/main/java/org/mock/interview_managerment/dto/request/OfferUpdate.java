package org.mock.interview_managerment.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.*;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OfferUpdate {
    private Long offerId;
    private Double basicSalary;
    private Date dueDate;
    private Date endContract;
    private Date startContract;
    private String note;

    private ContractTypeEnum contractType;

    private DepartmentEnum department;

    private LevelEnum level;

    private PositionEnum position;

    private OfferStatusEnum status;

    private User approver;

    private Interview interview;

    private Candidate candidate;

    private User recruiter;

}
