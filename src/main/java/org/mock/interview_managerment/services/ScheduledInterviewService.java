package org.mock.interview_managerment.services;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.ScheduledInterview;
import org.mock.interview_managerment.repository.ScheduledInterviewRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ScheduledInterviewService {
    private final ScheduledInterviewRepository scheduledInterviewRepository;
    private final InterviewService interviewService;
    private final UserService userService;

    public ScheduledInterview saveScheduledInterview(ScheduledInterview scheduledInterview) {
        scheduledInterview.setDeleted(false);
        return scheduledInterviewRepository.save(scheduledInterview);
    }
    public void deleteScheduledInterviewByInterviewId(long interviewId) {
        List<ScheduledInterview> scheduledInterviews = scheduledInterviewRepository.findAllByInterviewId(interviewId);
        scheduledInterviews.forEach(scheduledInterview -> {
            scheduledInterview.setDeleted(true);
            scheduledInterviewRepository.save(scheduledInterview);
        });
    }
    public List<ScheduledInterview> getScheduledInterviewByInterviewId(long interviewId) {
        return scheduledInterviewRepository.findAllByInterviewId(interviewId);
    }
}
