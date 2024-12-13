package org.mock.interview_managerment.controller.admin;

import org.mock.interview_managerment.entities.Job;
import org.mock.interview_managerment.enums.StatusJobEnum;
import org.mock.interview_managerment.services.JobService;
import org.mock.interview_managerment.services.JobFileParser;

import org.mock.interview_managerment.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class JobController {
    @Autowired
    private JobService jobService;
    @Autowired
    private JobFileParser jobFileParser;
    @Autowired
    private UserService userService;

    @RequestMapping("/job")
    public String listJobs(Model model,
            @RequestParam("p") Optional<Integer> p,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "status", required = false) String status) {

        int pageNumber = p.orElse(0);
        Pageable pageable = PageRequest.of(pageNumber, 10);
        Page<Job> page;

        StatusJobEnum statusEnum = null;
        if (status != null && !status.isEmpty()) {
            try {
                statusEnum = StatusJobEnum.valueOf(status.toUpperCase());
            } catch (IllegalArgumentException e) {
                model.addAttribute("error", "Invalid status value: " + status);
                return "job/jobList";
            }
        }

        if (statusEnum == null && (keyword != null && !keyword.isEmpty())) {
            page = jobService.searchJobsStatusNull(keyword, pageable);
        } else if (statusEnum != null) {
            page = jobService.searchJobs(keyword, statusEnum, pageable);
        } else {
            page = jobService.getJobs(pageable);
        }

        jobService.updateJobStatus(page);

        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("listjobs", page);
        model.addAttribute("isAdminOrManagerOrRecruiter", userService.isAdminOrManagerOrRecruiter());
        return "job/jobList";
    }

    @GetMapping("/job/import")
    public String showImportPage() {
        return "job/import";
    }

    @PostMapping("/job/import")
    public String handleFileUpload(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
        try {
            // Kiểm tra định dạng tệp và nội dung
            if (!file.getOriginalFilename().endsWith(".xls") && !file.getOriginalFilename().endsWith(".xlsx")) {
                redirectAttributes.addFlashAttribute("errorMessage", "File không đúng định dạng Excel.");
                return "redirect:/job";
            }

            // Phân tích tệp và lưu danh sách job
            List<Job> jobs = jobFileParser.parseExcelFile(file);
            jobService.saveListJob(jobs);
            if (jobs.isEmpty()) {
                // Nếu danh sách jobs rỗng
                redirectAttributes.addFlashAttribute("successMessage",
                        "No jobs to import. The file is empty or not in the correct format.");
            } else {
                // Nếu danh sách jobs không rỗng

                redirectAttributes.addFlashAttribute("successMessage", "Jobs imported successfully!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể import vì file không đúng định dạng.");
            return "redirect:/job/import";
        }

        return "redirect:/job";
    }

    @GetMapping("/job/create")
    public String showCreateJobForm(Model model) {
        model.addAttribute("job", new Job());
        return "job/createJob";
    }

    @PostMapping("/job/create")
    public String createJob(
            @RequestParam String title,
            @RequestParam String description,
            @RequestParam String requiredSkills,
            @RequestParam String level,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam String location,
            @RequestParam String benefits,
            @RequestParam String salaryFrom,
            @RequestParam String salaryTo,
            Model model,
            RedirectAttributes redirectAttributes) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            // Parse String to Date
            Date start = format.parse(startDate);
            Date end = format.parse(endDate);

            // Convert Date to Timestamp
            Timestamp startTimestamp = new Timestamp(start.getTime());
            Timestamp endTimestamp = new Timestamp(end.getTime());

            // Create new Job entity
            Job job = new Job();
            job.setTitle(title);
            job.setDescription(description);
            job.setRequiredSkills(requiredSkills);
            job.setLevel(level);
            job.setStartDate(startTimestamp);
            job.setEndDate(endTimestamp);
            job.setLocation(location);
            job.setBenefits(benefits);
            job.setSalaryFrom(salaryFrom);
            job.setSalaryTo(salaryTo);
            job.setLastModifiedBy(userService.getCurrentUsername());
            jobService.updateStatusJob(job);

            // Save Job
            jobService.saveJob(job);

            // Add success message
            redirectAttributes.addFlashAttribute("successMessage", "Job created successfully!");

            // Redirect to job list page
            return "redirect:/job";

        } catch (ParseException e) {
            // Handle parse exception
            e.printStackTrace();
            return "error"; // Return to an error page or handle accordingly
        }
    }

    @RequestMapping("/job/detail/{id}")
    public String getJobrDetailPage(Model model, @PathVariable long id) {
        System.out.println("check path id = " + id);
        Job jobdetail = this.jobService.getJobById(id);
        model.addAttribute("jobdetail", jobdetail);
        model.addAttribute("isAdminOrManagerOrRecruiter", userService.isAdminOrManagerOrRecruiter());
        return "job/jobDetail";
    }

    @RequestMapping("/job/delete/{id}")
    public String getDeleteJob(Model model, @PathVariable long id) {
        jobService.softDeleteJobById(id);
        return "redirect:/job";
    }

    @RequestMapping("/job/update/{id}")
    public String getJobUpdatePage(Model model, @PathVariable long id) {
        Job updateJob = this.jobService.getJobById(id);
        System.out.println(updateJob);
        model.addAttribute("update", updateJob);
        return "job/updateJob";
    }

    @PostMapping("/job/update")
    public String updateJob(@RequestParam Long jobId,
            @RequestParam String title,
            @RequestParam String description,
            @RequestParam String requiredSkills,
            @RequestParam String level,
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam String location,
            @RequestParam String benefits,
            @RequestParam String salaryFrom,
            @RequestParam String salaryTo,
            Model model) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            // Parse String to Date
            Date start = format.parse(startDate);
            Date end = format.parse(endDate);

            // Convert Date to Timestamp
            Timestamp startTimestamp = new Timestamp(start.getTime());
            Timestamp endTimestamp = new Timestamp(end.getTime());

            // Create new Job entity
            Job job = this.jobService.getJobById(jobId);
            job.setTitle(title);
            job.setDescription(description);
            job.setRequiredSkills(requiredSkills);
            job.setLevel(level);
            job.setStartDate(startTimestamp);
            job.setEndDate(endTimestamp);
            job.setLocation(location);
            job.setBenefits(benefits);
            job.setSalaryFrom(salaryFrom);
            job.setSalaryTo(salaryTo);
            job.setLastModifiedBy(userService.getCurrentUsername());
            jobService.updateStatusJob(job);

            // Save Job
            jobService.saveJob(job);

            // Redirect to job list page or success page
            return "redirect:/job";

        } catch (ParseException e) {
            // Handle parse exception
            e.printStackTrace();
            return "error"; // Return to an error page or handle accordingly
        }
    }

}
