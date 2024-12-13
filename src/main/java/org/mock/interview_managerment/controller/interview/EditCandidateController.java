package org.mock.interview_managerment.controller.interview;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.repository.CandidateRepository;
import org.mock.interview_managerment.services.CandidateJobService;
import org.mock.interview_managerment.services.InterviewService;
import org.mock.interview_managerment.services.ScheduledInterviewService;
import org.mock.interview_managerment.services.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
@Controller
@RequiredArgsConstructor
public class EditCandidateController {
    private final CandidateRepository candidateRepository;
    private final UserService userService;
    private final InterviewService interviewService;
    private final ScheduledInterviewService scheduledInterviewService;
    private final CandidateJobService candidateJobService;

    @GetMapping("/interview/edit_candidate")
    public String getEditCandidate(@RequestParam("interviewId") long interviewId, Model model) {
        List<Candidate> candidates = candidateRepository.findAll();
        Interview interview = interviewService.getByInterviewId(interviewId);

        model.addAttribute("candidates", candidates);
        model.addAttribute("interview", interview);
        model.addAttribute("newInterview", interview);

        return "interview/edit_candidate";
    }


    @PostMapping("/interview/edit_candidate")
    public String postEditCandidate(@ModelAttribute("newInterview") Interview newInterview, Model model) {
        long candidateId = newInterview.getCandidate().getId();
        long interviewId = newInterview.getInterviewId();
        return "redirect:/interview/edit_details?interviewId=" + interviewId + "&candidateId=" + candidateId;
    }
}


