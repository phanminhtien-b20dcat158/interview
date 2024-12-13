package org.mock.interview_managerment.repository;

import org.mock.interview_managerment.entities.ScheduledInterview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ScheduledInterviewRepository extends JpaRepository<ScheduledInterview, Long> {
    @Override
    @Query("SELECT s FROM ScheduledInterview s WHERE s.deleted = false")
    List<ScheduledInterview> findAll();

    @Query("SELECT s FROM ScheduledInterview s WHERE s.interview.interviewId = :interviewId AND s.deleted = false")
    List<ScheduledInterview> findAllByInterviewId(long interviewId);

    @Query("SELECT s FROM ScheduledInterview s WHERE s.interviewer.userId = :interviewerId AND s.deleted = false")
    List<ScheduledInterview> findAllByInterviewerId(long interviewerId);
}
