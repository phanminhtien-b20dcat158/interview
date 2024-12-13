package org.mock.interview_managerment.controller;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotNull;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.entities.Interview;
import org.mock.interview_managerment.entities.Offer;
import org.mock.interview_managerment.enums.*;
import org.mock.interview_managerment.repository.OfferRepository;
import org.mock.interview_managerment.services.*;
import org.mock.interview_managerment.util.OfferUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
//import org.springframework.security.access.annotation.Secured;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/offers")
public class OfferController {

    @Autowired
    private OfferService offerService;
    @Autowired
    private CandidateService candidateService;
    @Autowired
    private UserService userService;
    @Autowired
    private InterviewService interviewService;
    @Autowired
    private OfferRepository offerRepository;

    @GetMapping
    @PreAuthorize("hasRole('MANAGER')")
    public String listOffers(Model model,
                             @RequestParam(defaultValue = "0") int page,
                             @RequestParam(defaultValue = "10") int size,
                             @RequestParam(required = false) String keyword,
                             @RequestParam(required = false) DepartmentEnum department,
                             @RequestParam(required = false) OfferStatusEnum status) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Offer> offerPage;

        if (StringUtils.isNotBlank(keyword) || department != null || status != null) {
            offerPage = offerService.findOffersByDepartmentAndStatusAndSearchKey(department, status, keyword, pageable);
            model.addAttribute("keyword", keyword);
            model.addAttribute("department", department);
            model.addAttribute("status", status);
        } else {
            offerPage = offerService.getAllOffers(pageable);
        }

        model.addAttribute("offerPage", offerPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", offerPage.getTotalPages());
        model.addAttribute("departments", DepartmentEnum.values());
        model.addAttribute("statuses", OfferStatusEnum.values());
        return "offers/index";
    }

    @GetMapping("/delete/{id}")
    public String deleteOffer(@PathVariable Long id) {
        offerService.deleteOffer(id);
        return "redirect:/offers";
    }

    @PostMapping("/cancel/{id}")
    public String cancelOffer(@PathVariable Long id,@RequestParam String note, RedirectAttributes redirectAttributes) {
        Offer offer = offerService.findById(id);
        if (offer != null) { // Check if the offer is found
            // Approve the offer
            offerService.cancelOffer(id);
            offer.setNote(note);
            offerService.saveOffer(offer);
            // Update the candidate's status
            Candidate candidate = offer.getCandidate();
            candidate.setStatus(StatusCandidateEnum.Cancelled_offer);
            candidateService.updateCandidatenew(candidate.getId(), candidate);

            Interview interview = offer.getInterview();
            interview.setStatus(StatusInterviewEnum.CANCELLED);
            interviewService.saveInterview(interview);

            redirectAttributes.addFlashAttribute("message", "Offer approved successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Offer not found.");
        }
        return "redirect:/offers"; // redirect to offer list
    }

    @PostMapping("/approve/{id}")
    public String approveOffer(@PathVariable Long id, @RequestParam String note, RedirectAttributes redirectAttributes) {
        Offer offer = offerService.findById(id);
        if (offer != null) { // Check if the offer is found
            // Approve the offer
            offer.setNote(note);
            offerService.saveOffer(offer);
            offerService.approveOffer(id);

            // Update the candidate's status
            Candidate candidate = offer.getCandidate();
            candidate.setStatus(StatusCandidateEnum.Approved_offer);
            candidateService.updateCandidatenew(offer.getCandidate().getId(), candidate);

            redirectAttributes.addFlashAttribute("message", "Offer approved successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Offer not found.");
        }
        return "redirect:/offers"; // redirect to offer list
    }


    @PostMapping("/reject/{id}")
    public String rejectOffer(@PathVariable Long id,@RequestParam String note, RedirectAttributes redirectAttributes) {
        Offer offer = offerService.findById(id);
        if (offer != null) { // Check if the offer is found
            // Approve the offer
            offerService.rejectOffer(id);
            offer.setNote(note);
            offerService.saveOffer(offer);
            // Update the candidate's status
            Candidate candidate = offer.getCandidate();
            candidate.setStatus(StatusCandidateEnum.Rejected_offer);
            candidateService.updateCandidatenew(candidate.getId(), candidate);

            redirectAttributes.addFlashAttribute("message", "Offer approved successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Offer not found.");
        }
        return "redirect:/offers"; // redirect to offer list
    }

    @GetMapping("/send/{id}")
    public String markAsSent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Offer offer = offerService.findById(id);
        if (offer != null) { // Check if the offer is found
            // Approve the offer
            offerService.markAsSent(id);

            // Update the candidate's status
            Candidate candidate = offer.getCandidate();
            candidate.setStatus(StatusCandidateEnum.Waiting_for_response);
            candidateService.updateCandidatenew(candidate.getId(), candidate);

            redirectAttributes.addFlashAttribute("message", "Offer approved successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Offer not found.");
        }
        return "redirect:/offers"; // redirect to offer list
    }

    @PostMapping("/decline/{id}")
    public String declineOffer(@PathVariable Long id, @RequestParam String note,RedirectAttributes redirectAttributes) {

        Offer offer = offerService.findById(id);
        if (offer != null) { // Check if the offer is found
            // Approve the offer
            offerService.declineOffer(id);
            offer.setNote(note);
            offerService.saveOffer(offer);

            // Update the candidate's status
            Candidate candidate = offer.getCandidate();
            candidate.setStatus(StatusCandidateEnum.Declined_offer);
            candidateService.updateCandidatenew(candidate.getId(), candidate);

            redirectAttributes.addFlashAttribute("message", "Offer approved successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Offer not found.");
        }
        return "redirect:/offers"; // redirect to offer list
    }

    @PostMapping("/accept/{id}")
    public String acceptOffer(@PathVariable Long id ,@RequestParam String note, RedirectAttributes redirectAttributes) {


        Offer offer = offerService.findById(id);
        if (offer != null) { // Check if the offer is found
            // Approve the offer
            offerService.acceptOffer(id);
            offer.setNote(note);
            offerService.saveOffer(offer);

            // Update the candidate's status
            Candidate candidate = offer.getCandidate();
            candidate.setStatus(StatusCandidateEnum.Accepted_offer);
            candidateService.updateCandidatenew(candidate.getId(), candidate);

            redirectAttributes.addFlashAttribute("message", "Offer approved successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Offer not found.");
        }
        return "redirect:/offers"; // redirect to offer list
    }


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(dateFormat, true));
    }

    @GetMapping("/new")
    public String createOfferForm(Model model) {
        model.addAttribute("offer", new Offer());
        populateModelAttributes(model);
        return "offers/create_offer";
    }

    @PostMapping
    public String saveOffer(@ModelAttribute("offer") Offer offer, BindingResult result, Model model) {
        offer.setStatus(OfferStatusEnum.WAITING_FOR_APPROVAL);

        // các properti nà
        // Check for @NotNull fields
        validateNotNullFields(offer, result);

        // Kiểm tra logic: startContract trước endContract
        if (offer.getStartContract().after(offer.getEndContract())) {
            result.rejectValue("startContract", "error.offer", "Start date must be before end date.");
            populateModelAttributes(model);
        }

        // Kiểm tra logic: dueDate trong tương lai
        if (offer.getDueDate().before(new Date())) {
            result.rejectValue("dueDate", "error.offer", "Due date must be in the future.");
            populateModelAttributes(model);
        }

        if (result.hasErrors()) {
            populateModelAttributes(model);
            return "offers/create_offer";
        }

        Candidate candidate = candidateService.getById(offer.getCandidate().getId()).getBody();
        candidate.setStatus(StatusCandidateEnum.Waiting_for_approval);
        candidateService.updateCandidatenew(candidate.getId(), candidate);
        offerService.saveOffer(offer);
        return "redirect:/offers";
    }

    @GetMapping("/edit/{id}")
    public String editOfferForm(@PathVariable Long id, Model model) {
        String redirect = OfferUtils.checkOfferStatus(id, offerService);
        if (redirect != null) {
            return redirect;
        }

        Offer offer = offerService.getOfferById(id);

        if (offer == null) {
            return "redirect:/offers";
        }

        if (offer.getStatus() == OfferStatusEnum.APPROVED) {
            return "redirect:/offers/detail/" + id;
        }

        model.addAttribute("offer", offer);
        populateModelAttributes(model);
        return "offers/edit_offer";
    }


    @PostMapping("/{id}")
    public String updateOffer(@PathVariable Long id, @ModelAttribute("offer") Offer offer, BindingResult result, Model model) {
        String redirect = OfferUtils.checkOfferStatus(id, offerService);
        if (redirect != null) {
            return redirect;
        }
        if (result.hasErrors()) {
            offer.setOfferId(id);
            populateModelAttributes(model);
            return "offers/edit_offer";
        }

        // Kiểm tra logic: startContract trước endContract
        if (offer.getStartContract().after(offer.getEndContract())) {
            result.rejectValue("startContract", "error.offer", "Start date must be before end date.");
            populateModelAttributes(model);
            return "offers/create_offer";
        }

        // Kiểm tra logic: dueDate trong tương lai
        if (offer.getDueDate().before(new Date())) {
            result.rejectValue("dueDate", "error.offer", "Due date must be in the future.");
            populateModelAttributes(model);
            return "offers/create_offer";
        }
        if(offer.getStatus() == OfferStatusEnum.REJECTED) {
            offer.setStatus(OfferStatusEnum.WAITING_FOR_APPROVAL);
        }

        offer.setOfferId(id);
        offerService.updateOffer(offer);
        return "redirect:/offers";
    }

    @GetMapping("/detail/{id}")
    public String viewOfferDetail(@PathVariable Long id, Model model, @AuthenticationPrincipal UserDetails userDetails) {
        Offer offer = offerService.getOfferById(id);
        model.addAttribute("user", userDetails.getClass());
        if (offer != null) {
            model.addAttribute("offer", offer);

            // Định dạng ngày
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-YYYY");
            String startDate = dateFormat.format(offer.getStartContract());
            String endDate = dateFormat.format(offer.getEndContract());
            String dueDate = dateFormat.format(offer.getDueDate());

            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);
            model.addAttribute("dueDate", endDate);
            return "offers/detail_offer";
        }
        return "redirect:/offers";
    }

    @GetMapping("/export")
    public String filterOffers(Model model, @RequestParam(required = false) Date start, @RequestParam(required = false) Date end) {
        if (start != null && end != null) {
            List<Offer> filteredOffers = offerService.getOffersByDateRange(start, end);
            model.addAttribute("offers", filteredOffers);
        }


        // Add the start and end dates back to the model to repopulate the form fields
        model.addAttribute("start", start);
        model.addAttribute("end", end);

        // Load necessary data for dropdowns and other form elements if required
        populateModelAttributes(model);
        return "offers/export-offer";
    }


    @PostMapping("/export")
    public void exportOffers(HttpServletResponse response,
                             @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
                             @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) throws IOException {
        List<Offer> offers = offerRepository.findByCreatedAtBetween(startDate, endDate);

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Offers");

        // Create header row
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("Offer ID");
        header.createCell(1).setCellValue("Basic Salary");
        header.createCell(2).setCellValue("Due Date");
        header.createCell(3).setCellValue("Start Contract");
        header.createCell(4).setCellValue("End Contract");
        header.createCell(5).setCellValue("Note");
        header.createCell(6).setCellValue("Contract Type");
        header.createCell(7).setCellValue("Department");
        header.createCell(8).setCellValue("Level");
        header.createCell(9).setCellValue("Position");
        header.createCell(10).setCellValue("Status");
        header.createCell(14).setCellValue("Created At");
        header.createCell(15).setCellValue("Updated At");

        // Fill data
        int rowNum = 1;
        for (Offer offer : offers) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(offer.getOfferId());
            row.createCell(1).setCellValue(offer.getBasicSalary());
            row.createCell(2).setCellValue(offer.getDueDate().toString());
            row.createCell(3).setCellValue(offer.getStartContract().toString());
            row.createCell(4).setCellValue(offer.getEndContract().toString());
            row.createCell(5).setCellValue(offer.getNote());
            row.createCell(6).setCellValue(offer.getContractType().toString());
            row.createCell(7).setCellValue(offer.getDepartment().toString());
            row.createCell(8).setCellValue(offer.getLevel().toString());
            row.createCell(9).setCellValue(offer.getPosition().toString());
            row.createCell(10).setCellValue(offer.getStatus() != null ? offer.getStatus().toString() : "");
            row.createCell(14).setCellValue(offer.getCreatedAt().toString());
            row.createCell(15).setCellValue(offer.getUpdatedAt().toString());
        }

        // Write to response
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=offers.xlsx");

        try (OutputStream os = response.getOutputStream()) {
            workbook.write(os);
        }

        workbook.close();
    }
    private void validateNotNullFields(Offer offer, BindingResult result) {
        Field[] fields = Offer.class.getDeclaredFields();
        for (Field field : fields) {
            if (field.isAnnotationPresent(NotNull.class)) {
                field.setAccessible(true);
                try {
                    if (field.get(offer) == null) {
                        result.rejectValue(field.getName(), "error.offer", field.getName() + " must not be null.");
                    }
                } catch (IllegalAccessException e) {
                    // Handle exception if necessary
                }
            }
        }
    }

    private void populateModelAttributes(Model model) {
        model.addAttribute("contractTypes", ContractTypeEnum.values());
        model.addAttribute("departments", DepartmentEnum.values());
        model.addAttribute("levels", LevelEnum.values());
        model.addAttribute("positions", PositionEnum.values());
        model.addAttribute("statuses", OfferStatusEnum.values());
        model.addAttribute("candidates", candidateService.getCandidatesWithPassedInterview());
        model.addAttribute("interviews", interviewService.getAllInterviews());
        model.addAttribute("managers", userService.getManagers());
        model.addAttribute("recruiters", userService.getRecruiters());
    }
}
