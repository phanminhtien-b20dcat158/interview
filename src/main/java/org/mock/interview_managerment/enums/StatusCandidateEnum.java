package org.mock.interview_managerment.enums;

public enum StatusCandidateEnum {
    OPEN ("OPEN"),
    Waiting_for_interview ("Waiting for interview"),
    Cancelled_interview("Cancelled interview"),
    Passed_Interview("Passed Interview"),
    Failed_interview("Failed interview"),
    Waiting_for_approval("Waiting for approval"),
    Approved_offer("Approved offer"),
    Rejected_offer("Rejected offer"),
    Waiting_for_response("Waiting for response"),
    Accepted_offer("Accepted offer"),
    Declined_offer("Declined offer"),
    Cancelled_offer("Cancelled offer"),
    BANNED("Banned");
    private String value;
    private StatusCandidateEnum(String value) {
        this.value = value;
    }
}
