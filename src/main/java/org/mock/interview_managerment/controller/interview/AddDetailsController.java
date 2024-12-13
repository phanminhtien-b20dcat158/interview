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
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AddDetailsController {
    private final UserService userService;
    private final CandidateService candidateService;
    private final InterviewService interviewService;
    private final ScheduledInterviewService scheduledInterviewService;
    private final CandidateJobService candidateJobService;
    private final JobService jobService;

    @GetMapping("/interview/add_details")
    public String getAddDetailsPage(@RequestParam("candidateId") long candidateId, @RequestParam("jobId") long jobId, Model model) {
        List<User> interviewers = userService.getUsersByRoleName("INTERVIEWER");
        List<CandidateJob> candidateJobs = candidateJobService.getAllJobOpenByCandidateId(candidateId);
        Candidate candidate = candidateService.getCandidateById(candidateId);


        model.addAttribute("interviewers", interviewers);
        model.addAttribute("candidateJobs", candidateJobs);
        model.addAttribute("candidate", candidate);

        if (!model.containsAttribute("newInterview")) {
            Interview interview = new Interview();
            if(jobId != 0) {
                Job job = jobService.getJobById(jobId);
                interview.setJob(job);
            }
            model.addAttribute("newInterview", interview);
        }


        return "interview/add_details";
    }

    @PostMapping("/interview/add_details")
    public String addNewInterviewDetails(@ModelAttribute("newInterview") @Valid Interview newInterview, BindingResult result, RedirectAttributes redirectAttributes) {

        // Kiểm tra và thêm lỗi nếu cần
        if (newInterview.getSelectedInterviewerIds().isEmpty()) {
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
            if (newInterview.getJob() == null || newInterview.getJob().getJobId() == null) {
                return "redirect:/interview/add_details?candidateId=" + newInterview.getCandidate().getId() + "&jobId=0";
            }else {
                return "redirect:/interview/add_details?candidateId=" + newInterview.getCandidate().getId() + "&jobId=" + newInterview.getJob().getJobId();
            }

        }

        newInterview.setResult(ResultInterviewEnum.OPEN);
        newInterview.setStatus(StatusInterviewEnum.NEW);

        long candidateId = newInterview.getCandidate().getId();
        Candidate candidate = candidateService.getCandidateById(candidateId);
        candidate.setStatus(StatusCandidateEnum.Waiting_for_interview);
        candidateService.updateCandidatenew(candidateId, candidate);

        Interview interview = interviewService.saveInterview(newInterview);

        List<Long> selectedInterviewerIds = newInterview.getSelectedInterviewerIds();
        for(Long selectedInterviewerId : selectedInterviewerIds) {
            ScheduledInterviewId scheduledInterviewId = new ScheduledInterviewId();
            scheduledInterviewId.setInterviewId(interview.getInterviewId());
            scheduledInterviewId.setInterviewerId(selectedInterviewerId);

            ScheduledInterview scheduledInterview = new ScheduledInterview();
            scheduledInterview.setScheduledInterviewId(scheduledInterviewId);
            scheduledInterview.setInterview(interview);
            scheduledInterview.setInterviewer(userService.getByUserId(selectedInterviewerId));

            scheduledInterviewService.saveScheduledInterview(scheduledInterview);
        }

        return "redirect:/interview/list";
    }

}
