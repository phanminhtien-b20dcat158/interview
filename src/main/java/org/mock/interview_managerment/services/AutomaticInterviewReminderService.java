package org.mock.interview_managerment.services;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AutomaticInterviewReminderService {

    @Autowired
    private final InterviewService interviewService;

    @Autowired
    private ScheduledInterviewService scheduledInterviewService;

    @Autowired
    private EmailService emailService;

    @Scheduled(cron = "0 0 8 * * ?")
    public void sendReminders() {
        LocalDate today = LocalDate.now();
        List<Interview> interviews = interviewService.getAllInterviewsByInterviewDate(today.plusDays(1));

        for (Interview interview : interviews) {
            interview.setScheduledInterviews(scheduledInterviewService.getScheduledInterviewByInterviewId(interview.getInterviewId()));

            //Gui cho candidate
            emailService.sendInterviewReminderForCandidate(interview.getCandidate().getEmail(), interview);

            //Gui cho cac interviewer
            interview.getScheduledInterviews().forEach(si -> {
                String toEmail = si.getInterviewer().getEmail();
                emailService.sendInterviewReminderForInterviewer(toEmail, interview);
            });

            interview.setStatus(StatusInterviewEnum.INVITED);

            interviewService.saveInterview(interview);
        }
    }
}
