package org.mock.interview_managerment.services;

import lombok.RequiredArgsConstructor;
import org.mock.interview_managerment.entities.CandidateJob;
import org.mock.interview_managerment.repository.CandidateJobRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CandidateJobService {
    private final CandidateJobRepository candidateJobRepository;

    public List<CandidateJob> getAllCandidateJobs() {
        return candidateJobRepository.findAll();
    }

    public List<CandidateJob> getAllJobOpenByCandidateId(Long id) {
        return candidateJobRepository.findAllJobOpenByCandidateId(id);
    }
}
