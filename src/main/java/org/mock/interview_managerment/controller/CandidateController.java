package org.mock.interview_managerment.controller;


import com.google.api.services.drive.model.File;
import jakarta.validation.Valid;

import org.mock.interview_managerment.dto.request.CandidateCreateDto;
import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.entities.CandidateJob;
import org.mock.interview_managerment.entities.Job;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.*;
import org.mock.interview_managerment.repository.CandidateRepository;
import org.mock.interview_managerment.services.CandidateService;
import org.mock.interview_managerment.services.JobService;
import org.mock.interview_managerment.services.UploadtoDriver;
import org.mock.interview_managerment.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;

@Controller()
public class CandidateController {
    @Autowired
    private CandidateService candidateService;
    @Autowired
    private UserService userService;
    @Autowired
    private JobService jobService;

    @GetMapping("/candidate")
    public String getAllCandidate(Model model, @RequestParam(value = "page", defaultValue = "0") int page, RedirectAttributes redirectAttributes) {
        Page<Candidate> candidates = null;

        candidates = candidateService.getAll(page).getBody();
        List<Candidate> candidates1 = candidates.getContent();

        List<Candidate> l = new ArrayList<>(candidates1);
//        l = sort(l);
        model.addAttribute("p", candidates);
        model.addAttribute("gender", GenderEnum.values());
        model.addAttribute("position", PositionEnum.values());
        model.addAttribute("highlevel", HighestLevelEnum.values());

        model.addAttribute("candidates", l);
        return "Candidate_view/list-candidate";
    }

    @GetMapping("/candidate/searchCandidate")
    public String search(@RequestParam(value = "search", defaultValue = "") String search, @RequestParam(value = "status", defaultValue = "") String status, Model model, @RequestParam(value = "page", defaultValue = "0") int page) {
        Page<Candidate> candidates = null;
        if (!status.equals("") && !search.equals("")) {
            StatusCandidateEnum status2 = StatusCandidateEnum.valueOf(status);
            candidates = candidateService.search(search, status2, page).getBody();

        }
        if (!status.equals("") && search.equals("")) {
            StatusCandidateEnum status2 = StatusCandidateEnum.valueOf(status);
            candidates = candidateService.findByStatus(status2, page).getBody();
        }
        if (status.equals("") && !search.equals("")) {
            candidates = candidateService.findBykey(search, page).getBody();
        }
        if (status.equals("") && search.equals("")) {
            candidates = candidateService.getAll(page).getBody();
        }
        if (candidates == null) {
            candidates = new PageImpl<>(new ArrayList<>(), PageRequest.of(page, 10), 0);
        }
        List<Candidate> candidates1 = candidates.getContent();
        List<Candidate> l = new ArrayList<>(candidates1);
        l = sort(l);
        model.addAttribute("p", candidates);
        model.addAttribute("candidates", l);
        if (candidates.isEmpty()) {
            model.addAttribute("message", "No item matches with your search data. Please try again");
        }
        String requestParams = "status=" + status + "&search=" + search;
        model.addAttribute("requestParams", requestParams);
        return "Candidate_view/list-candidate";
    }

    @GetMapping("/candidate/addCandidateForward")
    public String fowardAddCandidate(Model model) {
        User user=userService.getCurrentUser();
        model.addAttribute("user", user);
        List<Job> jobList = jobService.getAllJobs();
        model.addAttribute("jobList", jobList);
        List<User> users = userService.findByRoleforCandidate();
        model.addAttribute("recruiters", users);
        Candidate candidate = new Candidate();
        List<StatusCandidateEnum> statusneeds= Arrays.asList(StatusCandidateEnum.OPEN, StatusCandidateEnum.BANNED);
        model.addAttribute("status", statusneeds);
        model.addAttribute("candidate", candidate);

        return "Candidate_view/add-candidate";
    }

    @PostMapping("/candidate/addCandidate")
    public String createCandidate(@Valid @ModelAttribute("candidate") CandidateCreateDto candidateCreateDto, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes, @RequestParam("cv") MultipartFile filecv) {
        if (bindingResult.hasErrors()) {
            User user=userService.getCurrentUser();
            model.addAttribute("user", user);
            System.out.println(bindingResult.getAllErrors());
            model.addAttribute("bindingResult", bindingResult);
            model.addAttribute("message", "Failed to created candidate");
            model.addAttribute("candidate", candidateCreateDto);
            List<User> users = userService.findByRoleforCandidate();
            model.addAttribute("recruiters", users);
            return "Candidate_view/add-candidate";
        }
        try {
//            String fileName = storeFile(filecv);
            UploadtoDriver uploadtoDriver = new UploadtoDriver();
            uploadtoDriver.init();
            java.io.File tempFile = java.io.File.createTempFile("temp-file", ".tmp");
            byte[] bytes= filecv.getBytes();
            if(bytes.length>0){
                try (FileOutputStream fileOutputStream = new FileOutputStream(tempFile)) {
                    fileOutputStream.write(bytes);
                }
                File file = uploadtoDriver.uploadFile(uploadtoDriver.service,tempFile , "cv");
                candidateCreateDto.setCvAttachmentLink(file.getWebViewLink());

            }
            // Ghi dữ liệu từ byte array vào file

            candidateService.create(candidateCreateDto);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            redirectAttributes.addFlashAttribute("message", "Failed to created candidate");
            return "redirect:/candidate/addCandidateForward";
        }
        redirectAttributes.addFlashAttribute("message2", "Successfully created candidate");
        return "redirect:/candidate";
    }

    @GetMapping("/candidate/candidateDetail")
    public String viewDetail(@RequestParam("id") Long id, Model model) {
        Candidate candidate = candidateService.getById(id).getBody();
        model.addAttribute("candidate", candidate);
        return "Candidate_view/candidate-details";
    }

    @GetMapping("/candidate/updateForward")
    public String updateForward(@RequestParam("id") Long id, Model model) {
        Candidate candidate = candidateService.getById(id).getBody();
        model.addAttribute("candidate", candidate);
        User user=userService.getCurrentUser();
        model.addAttribute("user1", user);
        List<User> users = userService.findByRoleforCandidate();
        model.addAttribute("recruiters", users);
        return "Candidate_view/update-candidate";
    }

    @PostMapping("/candidate/updateCandidate")
    public String updateCandidate(@RequestParam("id") Long id, @Valid @ModelAttribute("candidate") CandidateCreateDto candidateCreateDto, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes, @RequestParam("cv") MultipartFile filecv) {
        if (bindingResult.hasErrors()) {
            candidateCreateDto.setId(id);
            User user=userService.getCurrentUser();
            model.addAttribute("user1", user);
            System.out.println(bindingResult.getAllErrors());
            model.addAttribute("bindingResult", bindingResult);
            model.addAttribute("message", "Failed to created candidate");
            List<User> users = userService.findByRoleforCandidate();
            model.addAttribute("recruiters", users);
            return "Candidate_view/update-candidate";
        }
        try {
//            String fileName = storeFile(filecv);
            UploadtoDriver uploadtoDriver = new UploadtoDriver();
            uploadtoDriver.init();
            java.io.File tempFile = java.io.File.createTempFile("temp-file", ".tmp");
            byte[] bytes= filecv.getBytes();
            // Ghi dữ liệu từ byte array vào file
            if(bytes.length>0){
                try (FileOutputStream fileOutputStream = new FileOutputStream(tempFile)) {
                    fileOutputStream.write(bytes);
                }
                File file = uploadtoDriver.uploadFile(uploadtoDriver.service,tempFile , "cv");
                candidateCreateDto.setCvAttachmentLink(file.getWebViewLink());

            }

            candidateService.updateCandidate(id,candidateCreateDto);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            candidateCreateDto.setId(id);
            redirectAttributes.addFlashAttribute("message", "Failed to created candidate");
            return "redirect:/candidate/updateForward";
        }
        return "redirect:/candidate";
    }

    public List<Candidate> sort(List<Candidate> candidates) {
        Comparator<Candidate> custom = (c1, c2) -> {
            int c1Status = getStatusIndex(c1.getStatus().toString());
            int c2Status = getStatusIndex(c2.getStatus().toString());
            return Integer.compare(c1Status, c2Status);
        };
        Collections.sort(candidates, new Comparator<Candidate>() {
            @Override
            public int compare(Candidate c1, Candidate c2) {
                int c1Status = getStatusIndex(c1.getStatus().toString());
                int c2Status = getStatusIndex(c2.getStatus().toString());
                return Integer.compare(c1Status, c2Status);
            }


        });
        return candidates;
    }

    @GetMapping("/candidate/delete")
    public String deleteCandidate(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
        candidateService.deleteCandidate(id);
        redirectAttributes.addFlashAttribute("message2", "Successfully delete candidate");

        return "redirect:/candidate";
    }

    @GetMapping("candidate/ban")
    public String banCandidate(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
        candidateService.banCandidate(id);
        return "redirect:/candidate";
    }

    private int getStatusIndex(String status) {
        switch (status) {
            case "Waiting_for_interview":
                return 0;
            case "Waiting_for_approval":
                return 1;
            case "Waiting_for_response":
                return 2;
            case "OPEN":
                return 3;
            case "Passed_Interview":
                return 4;
            case "Approved_Offer":
                return 5;
            case "Rejected_Offer":
                return 6;
            case "Accepted_offer":
                return 7;
            case "Declined_offer":
                return 8;
            case "Cancelled_offer":
                return 9;
            case "Failed_interview":
                return 10;
            case "Cancelled_interview":
                return 11;
            case "BANNED":
                return 12;
            default:
                return -1;
        }
    }




}
