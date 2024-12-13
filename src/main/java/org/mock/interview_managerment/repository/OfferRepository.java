package org.mock.interview_managerment.repository;

import org.mock.interview_managerment.entities.Job;
import org.mock.interview_managerment.entities.Offer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface OfferRepository extends JpaRepository<Offer, Long> {
    Page<Offer> findAll(Pageable pageable);

    Page<Offer> findAll(Specification<Offer> spec, Pageable pageable);
    @Query("SELECT o FROM Offer o WHERE o.deleted = false")
    Page<Offer> findAllActiveOffers(Pageable pageable);

    @Query("SELECT o FROM Offer o WHERE o.createdAt BETWEEN :start AND :end")
    List<Offer> findByDateRange(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    List<Offer> findByCreatedAtBetween(LocalDateTime startDate, LocalDateTime endDate);


    @Query("SELECT o FROM Offer o WHERE " +
            "LOWER(o.candidate.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.candidate.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.contractType) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.department) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.level) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.position) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.status) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Offer> findByKeyword(String keyword, Pageable pageable);

    @Query("SELECT o FROM Offer o WHERE " +
            "(LOWER(o.candidate.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.candidate.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.contractType) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.department) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.level) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.position) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(o.status) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
            "(:department IS NULL OR o.department = :department) AND " +
            "(:status IS NULL OR o.status = :status)")
    Page<Offer> findByKeywordAndDepartmentAndStatus(String keyword, String department, String status, Pageable pageable);

    @Modifying
    @Transactional
    @Query("DELETE FROM Offer o WHERE o.interview.interviewId = :interviewId")
    void deleteByInterviewId(@Param("interviewId") Long interviewId);
}
