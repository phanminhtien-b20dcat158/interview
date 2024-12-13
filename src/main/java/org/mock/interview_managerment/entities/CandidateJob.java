package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.mock.interview_managerment.entities.pk.CandidateJobId;

import java.io.Serializable;

@Data
@Entity
@Table(name = "candidate_jobs")
public class CandidateJob implements Serializable {

    @EmbeddedId
    private CandidateJobId candidateJobId;

    @ManyToOne
    @MapsId("candidateId")
    @JoinColumn(name = "candidate_id")
    private Candidate candidate;

    @ManyToOne
    @MapsId("jobId")
    @JoinColumn(name = "job_id")
    private Job job;

}
