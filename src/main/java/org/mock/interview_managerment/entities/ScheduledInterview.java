package org.mock.interview_managerment.entities;

import jakarta.persistence.*;
import lombok.Data;
import org.mock.interview_managerment.entities.pk.ScheduledInterviewId;

import java.io.Serializable;

@Data
@Entity
@Table(name = "scheduled_interviews")
public class ScheduledInterview implements Serializable {

    @EmbeddedId
    private ScheduledInterviewId ScheduledInterviewId;

    private boolean deleted = false;

    @ManyToOne
    @MapsId("interviewId")
    @JoinColumn(name = "interview_id")
    private Interview interview;

    @ManyToOne
    @MapsId("interviewerId")
    @JoinColumn(name = "interviewer_id")
    private User interviewer;
}
