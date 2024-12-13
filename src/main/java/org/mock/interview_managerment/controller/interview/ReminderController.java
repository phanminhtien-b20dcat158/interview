package org.mock.interview_managerment.controller.interview;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.services.EmailService;
import org.mock.interview_managerment.services.InterviewService;
import org.mock.interview_managerment.services.ScheduledInterviewService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class ReminderController {
    private final InterviewService interviewService;
    private final UserService userService;
    private final ScheduledInterviewService scheduledInterviewService;
    private final EmailService emailService;

    @GetMapping("/interview/reminder")
    public String getReminder(@RequestParam("interviewId") long interviewId, Model model, RedirectAttributes redirectAttributes) {
        Interview interview = interviewService.getByInterviewId(interviewId);
        interview.setScheduledInterviews(scheduledInterviewService.getScheduledInterviewByInterviewId(interview.getInterviewId()));

        try{
            //Gui cho candidate
            emailService.sendInterviewReminderForCandidate(interview.getCandidate().getEmail(), interview);

            //Gui cho cac interviewer
            interview.getScheduledInterviews().forEach(si -> {
                String toEmail = si.getInterviewer().getEmail();
                emailService.sendInterviewReminderForInterviewer(toEmail, interview);
            });

            interview.setStatus(StatusInterviewEnum.INVITED);

            interviewService.saveInterview(interview);

        }catch(Exception e){
            System.err.println("Failed to send email: " + e.getMessage());
            redirectAttributes.addFlashAttribute("emailError", "Failed to send email reminders. Please try again later.");
            return "redirect:/interview/details?interviewId=" + interviewId;
        }


        return "redirect:/interview/list";
    }
}
