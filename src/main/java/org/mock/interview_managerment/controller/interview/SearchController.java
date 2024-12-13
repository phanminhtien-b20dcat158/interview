package org.mock.interview_managerment.controller.interview;

import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.services.InterviewService;
import org.mock.interview_managerment.services.ScheduledInterviewService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SearchController {

    @Autowired
    private InterviewService interviewService;

    @Autowired
    private UserService userService;

    @Autowired
    private ScheduledInterviewService scheduledInterviewService;

    @GetMapping("/interview/search")
    public String search(@RequestParam(name = "interviewerId", required = false) Long interviewerId, @RequestParam(name = "status", required = false) StatusInterviewEnum status,
                         Model model) {
        List<Interview> interviews = interviewService.searchInterviews(interviewerId, status);
        interviews.forEach(interview -> {
            interview.setScheduledInterviews(scheduledInterviewService.getScheduledInterviewByInterviewId(interview.getInterviewId()));
        });


        List<User> interviewers = userService.getUsersByRoleName("INTERVIEWER");

        model.addAttribute("username", userService.getCurrentUsername());
        model.addAttribute("roleName", userService.getCurrentUserRole());
        model.addAttribute("interviews", interviews);
        model.addAttribute("states", StatusInterviewEnum.values());
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedInterviewerId", interviewerId);
        model.addAttribute("interviewers", interviewers);

        return "interview/list";
    }
}
