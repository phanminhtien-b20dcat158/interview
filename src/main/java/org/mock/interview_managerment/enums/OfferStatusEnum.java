package org.mock.interview_managerment.enums;

public enum OfferStatusEnum {
    WAITING_FOR_APPROVAL("Waiting for Approval"),
    REJECTED("Rejected"),
    APPROVED("Approved"),
    WAITING_FOR_RESPONSE("Waiting for response"),
    ACCEPTED("Accepted Offer"),
    DECLINED("Declined Offer"),
    CANCELLED("Cancelled");

    private String value;

    private OfferStatusEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static OfferStatusEnum fromValue(String value) {
        for (OfferStatusEnum status : values()) {
            if (status.getValue().equals(value)) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown value: " + value);
    }
}

