package org.mock.interview_managerment.services;

import org.mock.interview_managerment.dto.request.CandidateCreateDto;
import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.enums.ResultInterviewEnum;
import org.mock.interview_managerment.enums.StatusCandidateEnum;
import org.mock.interview_managerment.mapper.CandidateMapper;
import org.mock.interview_managerment.repository.CandidateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CandidateService {
    private CandidateRepository candidateRepository;
    @Autowired
    public CandidateService(CandidateRepository candidateRepository) {
        this.candidateRepository = candidateRepository;
    }
    public ResponseEntity<Page<Candidate>> getAll(int page){

        Pageable pageable= (Pageable) PageRequest.of(page,7);
        Page<Candidate> l= candidateRepository.findByIsDeletedFalse(pageable);
        return ResponseEntity.ok().body(l);
    }

    public ResponseEntity<Page<Candidate>> search(String keyword, StatusCandidateEnum status, int page){
        Pageable pageable= (Pageable) PageRequest.of(page,7);
        Page<Candidate> l= candidateRepository.findByKeywordAndStatus(keyword,pageable,status);
        return ResponseEntity.ok().body(l);
    }
    public ResponseEntity<Page<Candidate>> findByStatus(StatusCandidateEnum status, int page){
        Pageable pageable= (Pageable) PageRequest.of(page,7);
        Page<Candidate> l= candidateRepository.findByStatus(status,pageable);
        return ResponseEntity.ok().body(l);
    }
    public ResponseEntity<Page<Candidate>> findBykey(String keyword, int page){
        Pageable pageable= (Pageable) PageRequest.of(page,7);
        Page<Candidate> l= candidateRepository.findByKeyword(keyword,pageable);
        return ResponseEntity.ok().body(l);
    }
    public Candidate create(CandidateCreateDto c){
        Candidate candidate1= CandidateMapper.toCandidate(c);
        return candidateRepository.save(candidate1);
    }
    public ResponseEntity<Candidate> getById(long id){
        Candidate candidate= candidateRepository.getById(id);
        return ResponseEntity.ok().body(candidate);
    }
    public Candidate updateCandidate(Long id, CandidateCreateDto newCandidate) {
        Candidate candidate=candidateRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        Candidate candidate1= CandidateMapper.toCandidate(newCandidate);
        candidate1.setId(candidate.getId());
        candidateRepository.save(candidate1);
        return candidate1;
    }
    public void deleteCandidate(Long id){
        Candidate candidate=candidateRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        candidate.setIsDeleted(true);
        candidateRepository.save(candidate);
    }
    public void banCandidate(Long id){
        Candidate candidate=candidateRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        candidate.setStatus(StatusCandidateEnum.valueOf("BANNED"));
        candidateRepository.save(candidate);
    }


    @Transactional
    public Candidate updateCandidatenew(Long id, Candidate updatedCandidate) {
        Optional<Candidate> optionalCandidate = candidateRepository.findById(id);
        if (optionalCandidate.isPresent()) {
            Candidate existingCandidate = optionalCandidate.get();

            // Cập nhật các thuộc tính cần thiết
            existingCandidate.setName(updatedCandidate.getName());
            existingCandidate.setEmail(updatedCandidate.getEmail());
            existingCandidate.setPhone(updatedCandidate.getPhone());
            existingCandidate.setAddress(updatedCandidate.getAddress());
            existingCandidate.setDob(updatedCandidate.getDob());
            existingCandidate.setYearsExperience(updatedCandidate.getYearsExperience());
            existingCandidate.setCvAttachmentLink(updatedCandidate.getCvAttachmentLink());
            existingCandidate.setNote(updatedCandidate.getNote());
            existingCandidate.setSkills(updatedCandidate.getSkills());
            existingCandidate.setGender(updatedCandidate.getGender());
            existingCandidate.setHighestLevel(updatedCandidate.getHighestLevel());
            existingCandidate.setCurrentPosition(updatedCandidate.getCurrentPosition());
            existingCandidate.setStatus(updatedCandidate.getStatus());

            // Nếu trạng thái mới khác trạng thái hiện tại, cập nhật trạng thái
            if (updatedCandidate.getStatus() != null &&
                    updatedCandidate.getStatus() != existingCandidate.getStatus()) {
                existingCandidate.setStatus(updatedCandidate.getStatus());
            }

            // Lưu lại ứng viên đã cập nhật
            return candidateRepository.save(existingCandidate);
        } else {
            throw new IllegalArgumentException("Candidate not found with ID: " + id);
        }
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
    public List<Candidate> getAllActiveCandidates() {
        return candidateRepository.findAll().stream()
                .filter(candidate -> !candidate.getStatus().equals(StatusCandidateEnum.BANNED))
                .collect(Collectors.toList());
    }

    public List<Candidate> getAllCandidates() {
        return candidateRepository.findAll();
    }

    public Candidate getCandidateById(long id){
        return candidateRepository.findByCandidateId(id);
    }

    public List<Candidate> getCandidatesWithPassedInterview() {
        return candidateRepository.findCandidatesByInterviewResult(ResultInterviewEnum.PASS);
    }

}
