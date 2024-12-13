package org.mock.interview_managerment.util;

import jakarta.persistence.criteria.*;
import org.mock.interview_managerment.entities.Candidate;
import org.mock.interview_managerment.entities.Offer;
import org.mock.interview_managerment.enums.DepartmentEnum;
import org.mock.interview_managerment.enums.OfferStatusEnum;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class OfferSpecification implements Specification<Offer> {
    private DepartmentEnum department;
    private OfferStatusEnum status;
    private String searchKey;

    public OfferSpecification(DepartmentEnum department, OfferStatusEnum status, String searchKey) {
        this.department = department;
        this.status = status;
        this.searchKey = searchKey;
    }

    @Override
    public Predicate toPredicate(Root<Offer> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
        List<Predicate> predicates = new ArrayList<>();

        if (department != null) {
            predicates.add(builder.equal(root.get("department"), department));
        }

        if (status != null) {
            predicates.add(builder.equal(root.get("status"), status));
        }

        if (searchKey != null) {
            Join<Offer, Candidate> candidateJoin = root.join("candidate", JoinType.INNER);
            predicates.add(builder.like(candidateJoin.get("name"), "%" + searchKey + "%"));
        }

        return builder.and(predicates.toArray(new Predicate[0]));
    }
}
