package org.mock.interview_managerment.services;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.entities.ScheduledInterview;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.repository.*;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class InterviewService {
    private final InterviewRepository interviewRepository;
    private final CandidateRepository candidateRepository;
    private final JobRepository jobRepository;
    private final UserRepository userRepository;
    private final ScheduledInterviewRepository scheduledInterviewRepository;


    public List<Interview> getAllInterviews() {
        return interviewRepository.findAll();
    }

    public Interview saveInterview(Interview interview) {
        interview.setDeleted(false);
        return interviewRepository.save(interview);
    }

    public Interview getByInterviewId(Long id) {
        return interviewRepository.findByInterviewId(id);
    }

    public void deleteInterviewById(Long interviewId) {
        Interview interview = getByInterviewId(interviewId);
        interview.setDeleted(true);
        interviewRepository.save(interview);
    }

    public List<Interview> getAllInterviewsByInterviewDate(LocalDate date) {
        return interviewRepository.findAllByInterviewDate(date);
    }

    public List<Interview> searchInterviews(Long interviewerId, StatusInterviewEnum status) {
        List<Interview> interviews = new ArrayList<>();
        if(interviewerId != null && status != null){
            List<ScheduledInterview> scheduledInterviews = scheduledInterviewRepository.findAllByInterviewerId(interviewerId);
            scheduledInterviews.forEach(scheduledInterview -> {
                Interview interview = scheduledInterview.getInterview();
                if(interview.getStatus() == status) {
                    interviews.add(interview);
                }
            });
        }else if(interviewerId != null){
            List<ScheduledInterview> scheduledInterviews = scheduledInterviewRepository.findAllByInterviewerId(interviewerId);
            scheduledInterviews.forEach(scheduledInterview -> {
                Interview interview = scheduledInterview.getInterview();
                interviews.add(interview);
            });
        }else if(status != null){
            return interviewRepository.findAllByStatusInterview(status);
        }else {
            return interviewRepository.findAll();
        }
        return interviews;
    }
}
