package org.mock.interview_managerment.controller.interview;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.services.InterviewService;
import org.mock.interview_managerment.services.OfferService;
import org.mock.interview_managerment.services.ScheduledInterviewService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class CancelInterviewScheduleController {
    private final ScheduledInterviewService scheduledInterviewService;
    private final InterviewService interviewService;
    private final OfferService offerService;

    @GetMapping("/interview/delete")
    public String deleteInterview(@RequestParam("interviewId") long interviewId, Model model) {
        Interview interview = interviewService.getByInterviewId(interviewId);

        interview.setStatus(StatusInterviewEnum.CANCELLED);

        interviewService.saveInterview(interview);

        return "redirect:/interview/list";  // Redirect to avoid form resubmission issues
    }
}
