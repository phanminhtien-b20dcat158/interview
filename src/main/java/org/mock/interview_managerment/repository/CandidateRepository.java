package org.mock.interview_managerment.repository;



import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.enums.ResultInterviewEnum;
import org.mock.interview_managerment.enums.StatusCandidateEnum;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CandidateRepository extends JpaRepository<Candidate,Long> {
    public Page<Candidate> findByIsDeletedFalse(Pageable pageable);
    public Candidate save(Candidate candidate);

    public Candidate getById(Long id);
    public Page<Candidate> findByStatus(StatusCandidateEnum status, Pageable pageable);

    @Query("SELECT c FROM Candidate c WHERE c.isDeleted = false AND "
            + "(c.name LIKE %:keyword% OR c.phone LIKE %:keyword% OR "
            + "c.email LIKE %:keyword% OR CAST(c.currentPosition AS string) LIKE %:keyword% OR "
            + "c.user.fullName LIKE %:keyword%) "
            + "AND c.status = :status")
    public Page<Candidate> findByKeywordAndStatus(String keyword, Pageable pageable,StatusCandidateEnum status);

    @Query("SELECT c FROM Candidate c WHERE c.isDeleted = false AND "
            + "(c.name LIKE %:keyword% OR c.phone LIKE %:keyword% OR "
            + "c.email LIKE %:keyword% OR CAST(c.currentPosition AS string) LIKE %:keyword% OR "
            + "c.user.fullName LIKE %:keyword%) ")
    Page<Candidate> findByKeyword(String keyword, Pageable pageable);


    List<Candidate> findAll();
    @Query("SELECT c FROM Candidate c WHERE c.id = :id")
    Candidate findByCandidateId(long id);



    @Query("SELECT c FROM Candidate c JOIN c.interviews i WHERE i.result = :result")
    List<Candidate> findCandidatesByInterviewResult(@Param("result") ResultInterviewEnum result);
}
