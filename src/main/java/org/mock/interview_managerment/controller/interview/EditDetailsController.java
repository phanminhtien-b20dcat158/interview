package org.mock.interview_managerment.controller.interview;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.*;
import org.mock.interview_managerment.entities.pk.ScheduledInterviewId;
import org.mock.interview_managerment.enums.ResultInterviewEnum;
import org.mock.interview_managerment.enums.StatusCandidateEnum;
import org.mock.interview_managerment.enums.StatusInterviewEnum;
import org.mock.interview_managerment.services.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class EditDetailsController {

    private final UserService userService;
    private final CandidateService candidateService;
    private final InterviewService interviewService;
    private final ScheduledInterviewService scheduledInterviewService;
    private final CandidateJobService candidateJobService;

    @GetMapping("/interview/edit_details")
    public String getEditDetails(@RequestParam("interviewId") long interviewId, @RequestParam("candidateId") long candidateId, Model model) {
        List<User> interviewers = userService.getUsersByRoleName("INTERVIEWER");
        List<CandidateJob> candidateJobs = candidateJobService.getAllJobOpenByCandidateId(candidateId);
        Candidate candidate = candidateService.getCandidateById(candidateId);
        Interview interview = interviewService.getByInterviewId(interviewId);

        List<ScheduledInterview> scheduledInterviews = scheduledInterviewService.getScheduledInterviewByInterviewId(interviewId);
        List<Long> scheduledInterviewIds = new ArrayList<>();
        interview.setSelectedInterviewerIds(scheduledInterviewIds);
        for(ScheduledInterview s: scheduledInterviews) {
            interview.getSelectedInterviewerIds().add(s.getInterviewer().getUserId());
        }

        model.addAttribute("username", userService.getCurrentUsername());
        model.addAttribute("roleName", userService.getCurrentUserRole());
        model.addAttribute("interviewers", interviewers);
        model.addAttribute("candidateJobs", candidateJobs);
        model.addAttribute("candidate", candidate);
        model.addAttribute("results", ResultInterviewEnum.values());
        model.addAttribute("states", StatusInterviewEnum.values());
        model.addAttribute("interview", interview);

        if (!model.containsAttribute("newInterview")) {
            model.addAttribute("newInterview", interview);
        }



        return "interview/edit_details";
    }

    @PostMapping("/interview/edit_details")
    public String postEditDetails(@ModelAttribute("newInterview") @Valid Interview newInterview, BindingResult result, RedirectAttributes redirectAttributes) {

        String roleName = userService.getCurrentUserRole();

        if(roleName.equals("recruiter") || roleName.equals("admin") || roleName.equals("manager")) {
            // Kiểm tra và thêm lỗi nếu cần
            if (newInterview.getSelectedInterviewerIds() == null || newInterview.getSelectedInterviewerIds().isEmpty()) {
                result.rejectValue("selectedInterviewerIds", "error.newInterview", "Please select at least one interviewer.");
            }

            if (newInterview.getJob() == null || newInterview.getJob().getJobId() == null) {
                result.rejectValue("job.jobId", "error.newInterview", "Please select a job.");
            }

            if (newInterview.getCandidate() == null || newInterview.getCandidate().getId() == null) {
                result.rejectValue("candidate.id", "error.newInterview", "Vui lòng chọn một ứng viên.");
            }

            // Kiểm tra startTime và endTime
            if (newInterview.getStartTime() != null && newInterview.getEndTime() != null) {
                if (newInterview.getEndTime().isBefore(newInterview.getStartTime())) {
                    result.rejectValue("endTime", "error.newInterview", "The end time must not be less than the start time.");
                }
            }

            // Kiểm tra date không phải ngày trong quá khứ
            if (newInterview.getDate() != null) {
                LocalDate today = LocalDate.now();
                if (newInterview.getDate().isBefore(today)) {
                    result.rejectValue("date", "error.newInterview", "The date cannot be a date in the past.");
                }
            }

            if (result.hasErrors()) {
                // Log lỗi để kiểm tra
                result.getAllErrors().forEach(error -> {
                    System.out.println(error.getObjectName() + ": " + error.getDefaultMessage());
                });

                redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.newInterview", result);
                redirectAttributes.addFlashAttribute("newInterview", newInterview);

                return "redirect:/interview/edit_details?interviewId=" + newInterview.getInterviewId() + "&candidateId=" + newInterview.getCandidate().getId();
            }

        }

        if(roleName.equals("interviewer")) {
            List<ScheduledInterview> scheduledInterviews = scheduledInterviewService.getScheduledInterviewByInterviewId(newInterview.getInterviewId());
            List<Long> scheduledInterviewIds = new ArrayList<>();
            newInterview.setSelectedInterviewerIds(scheduledInterviewIds);
            for(ScheduledInterview s: scheduledInterviews) {
                newInterview.getSelectedInterviewerIds().add(s.getInterviewer().getUserId());
            }

        }

        if(roleName.equals("recruiter") || roleName.equals("admin") || roleName.equals("manager")) {
            scheduledInterviewService.deleteScheduledInterviewByInterviewId(newInterview.getInterviewId());
            interviewService.saveInterview(newInterview);
            if(newInterview.getResult() != ResultInterviewEnum.OPEN && newInterview.getResult() != ResultInterviewEnum.NA) {
                newInterview.setStatus(StatusInterviewEnum.INTERVIEWED);
            }

            if(newInterview.getResult() == ResultInterviewEnum.PASS) {
                long candidateId = newInterview.getCandidate().getId();
                Candidate candidate = candidateService.getCandidateById(candidateId);
                candidate.setStatus(StatusCandidateEnum.Passed_Interview);
                candidateService.updateCandidatenew(candidateId, candidate);
            }

            if(newInterview.getResult() == ResultInterviewEnum.FAILED) {
                long candidateId = newInterview.getCandidate().getId();
                Candidate candidate = candidateService.getCandidateById(candidateId);
                candidate.setStatus(StatusCandidateEnum.Failed_interview);
                candidateService.updateCandidatenew(candidateId, candidate);
            }


            interviewService.saveInterview(newInterview);
        }

        if(roleName.equals("interviewer")) {
            Interview interview = interviewService.getByInterviewId(newInterview.getInterviewId());
            interview.setNote(newInterview.getNote());
            interview.setResult(newInterview.getResult());
            if(newInterview.getResult() != ResultInterviewEnum.OPEN && newInterview.getResult() != ResultInterviewEnum.NA) {
                interview.setStatus(StatusInterviewEnum.INTERVIEWED);
            }

            if(newInterview.getResult() == ResultInterviewEnum.PASS) {
                long candidateId = newInterview.getCandidate().getId();
                Candidate candidate = candidateService.getCandidateById(candidateId);
                candidate.setStatus(StatusCandidateEnum.Passed_Interview);
                candidateService.updateCandidatenew(candidateId, candidate);
            }

            if(newInterview.getResult() == ResultInterviewEnum.FAILED) {
                long candidateId = newInterview.getCandidate().getId();
                Candidate candidate = candidateService.getCandidateById(candidateId);
                candidate.setStatus(StatusCandidateEnum.Failed_interview);
                candidateService.updateCandidatenew(candidateId, candidate);
            }

            interviewService.saveInterview(interview);
        }

        List<Long> selectedInterviewerIds = newInterview.getSelectedInterviewerIds();
        for(Long selectedInterviewerId : selectedInterviewerIds) {
            ScheduledInterviewId scheduledInterviewId = new ScheduledInterviewId();
            scheduledInterviewId.setInterviewId(newInterview.getInterviewId());
            scheduledInterviewId.setInterviewerId(selectedInterviewerId);

            ScheduledInterview scheduledInterview = new ScheduledInterview();
            scheduledInterview.setScheduledInterviewId(scheduledInterviewId);
            scheduledInterview.setInterview(newInterview);
            scheduledInterview.setInterviewer(userService.getByUserId(selectedInterviewerId));

            scheduledInterviewService.saveScheduledInterview(scheduledInterview);
        }

        return "redirect:/interview/list";
    }
}
