package org.mock.interview_managerment.services;

import jakarta.persistence.EntityNotFoundException;
import org.mock.interview_managerment.entities.Offer;
import org.mock.interview_managerment.entities.User;
import org.mock.interview_managerment.enums.DepartmentEnum;
import org.mock.interview_managerment.enums.OfferStatusEnum;
import org.mock.interview_managerment.repository.OfferRepository;
import org.mock.interview_managerment.repository.UserRepository;
import org.mock.interview_managerment.util.OfferSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Service
public class OfferService {

    @Autowired
    private OfferRepository offerRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private EmailService emailService;

    public Page<Offer> getOffers(int page, int size) {
        return offerRepository.findAll(PageRequest.of(page, size));
    }

    public Page<Offer> searchOffers(String keyword, String department, String status, Pageable pageable) {
        if (keyword == null && department == null && status == null) {
            return offerRepository.findAll(pageable);
        }
        return offerRepository.findByKeywordAndDepartmentAndStatus(keyword, department, status, pageable);
    }

    public List<Offer> getOffersByDateRange(Date start, Date end) {
        LocalDateTime startDateTime = convertToLocalDateTime(start);
        LocalDateTime endDateTime = convertToLocalDateTime(end);
        return offerRepository.findByDateRange(startDateTime, endDateTime);
    }

    private LocalDateTime convertToLocalDateTime(Date date) {
        return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
    }

    @Transactional
    public Offer updateOffer(Offer offer) {
        // Kiểm tra sự tồn tại của offer bằng ID trước khi cập nhật
        if (offerRepository.existsById(offer.getOfferId())) {
            // Thực hiện cập nhật
            return offerRepository.save(offer);
        } else {
            throw new EntityNotFoundException("Offer not found with ID: " + offer.getOfferId());
        }
    }

    public Page<Offer> getAllOffers(Pageable pageable) {
        return offerRepository.findAllActiveOffers(pageable);
    }

    public Page<Offer> findOffersByDepartmentAndStatusAndSearchKey(DepartmentEnum department, OfferStatusEnum status, String searchKey, Pageable pageable) {
        OfferSpecification specification = new OfferSpecification(department, status, searchKey);
        return offerRepository.findAll(specification, pageable);
    }

    public Offer saveOffer(Offer offer) {
        return offerRepository.save(offer);
    }

    public Offer getOfferById(Long id) {
        return offerRepository.findById(id).orElse(null);
    }

    public void deleteOffer(Long id) {
        Offer offer = getOfferById(id);
        if (offer != null) {
            offer.setDeleted(true);
            offerRepository.save(offer);
        }
    }

    public Offer findById(Long id) {
        return offerRepository.findById(id).orElseThrow(() -> new RuntimeException("Offer not found"));
    }

    public void cancelOffer(Long id) {
        Offer offer = findById(id);
        offer.setStatus(OfferStatusEnum.CANCELLED);
        offerRepository.save(offer);
    }

    public void approveOffer(Long id) {
        Offer offer = findById(id);
        offer.setStatus(OfferStatusEnum.APPROVED);
        offerRepository.save(offer);
    }

    public void rejectOffer(Long id) {
        Offer offer = findById(id);
        offer.setStatus(OfferStatusEnum.REJECTED);
        offerRepository.save(offer);
    }

    public void markAsSent(Long id) {
        Offer offer = findById(id);
        // Implement the logic for marking as sent to candidate
        emailService.sendOfferEmail(offer.getCandidate().getEmail(), offer);
        offer.setStatus(OfferStatusEnum.WAITING_FOR_RESPONSE);
        offerRepository.save(offer);
    }

    public void declineOffer(Long id) {
        Offer offer = findById(id);
        offer.setStatus(OfferStatusEnum.DECLINED);
        offerRepository.save(offer);
    }

    public void acceptOffer(Long id) {
        Offer offer = findById(id);
        offer.setStatus(OfferStatusEnum.ACCEPTED);
        offerRepository.save(offer);
    }

    public void deleteOfferByInterviewId(Long interviewId) {
        offerRepository.deleteByInterviewId(interviewId);
    }
}
