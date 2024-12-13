package org.mock.interview_managerment.controller.interview;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.services.InterviewService;
import org.mock.interview_managerment.services.ScheduledInterviewService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ListController {
    private final InterviewService interviewService;
    private final UserService userService;
    private final ScheduledInterviewService scheduledInterviewService;

    @GetMapping("/interview/list")
    public String getInterviewListPage(Model model) {
        List<Interview> interviews = interviewService.getAllInterviews();
        interviews.forEach(interview -> {
            interview.setScheduledInterviews(scheduledInterviewService.getScheduledInterviewByInterviewId(interview.getInterviewId()));
        });

        List<User> interviewers = userService.getUsersByRoleName("INTERVIEWER");


        model.addAttribute("username", userService.getCurrentUsername());
        model.addAttribute("roleName", userService.getCurrentUserRole());
        model.addAttribute("interviews", interviews);
        model.addAttribute("interviewers", interviewers);
        model.addAttribute("states", StatusInterviewEnum.values());


        return "interview/list";
    }
}