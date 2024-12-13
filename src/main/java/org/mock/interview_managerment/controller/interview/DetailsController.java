package org.mock.interview_managerment.controller.interview;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.services.InterviewService;
import org.mock.interview_managerment.services.ScheduledInterviewService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class DetailsController {
    private final InterviewService interviewService;
    private final UserService userService;
    private final ScheduledInterviewService scheduledInterviewService;

    @GetMapping("/interview/details")
    public String getInterviewDetailsPage(@RequestParam("interviewId") long interviewId, Model model) {

        Interview interview = interviewService.getByInterviewId(interviewId);
        interview.setScheduledInterviews(scheduledInterviewService.getScheduledInterviewByInterviewId(interview.getInterviewId()));
        
        model.addAttribute("username", userService.getCurrentUsername());
        model.addAttribute("roleName", userService.getCurrentUserRole());
        model.addAttribute("interview", interview);

        return "interview/details";
    }

}


