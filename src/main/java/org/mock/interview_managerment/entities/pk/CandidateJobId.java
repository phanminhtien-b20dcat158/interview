package org.mock.interview_managerment.entities.pk;

import jakarta.persistence.Embeddable;
import lombok.Data;

import java.io.Serializable;

@Data
@Embeddable
public class CandidateJobId implements Serializable {
    private Long candidateId;
    private Long jobId;
}
