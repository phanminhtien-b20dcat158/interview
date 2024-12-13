package org.mock.interview_managerment.util;

import org.mock.interview_managerment.entities.Offer;
import org.mock.interview_managerment.enums.OfferStatusEnum;
import org.mock.interview_managerment.services.OfferService;

public class OfferUtils {

    public static String checkOfferStatus(Long id, OfferService offerService) {
        Offer offer = offerService.getOfferById(id);

        if (offer == null) {
            return "redirect:/offers";
        }

        if ((offer.getStatus() != OfferStatusEnum.WAITING_FOR_APPROVAL) && (offer.getStatus() != OfferStatusEnum.WAITING_FOR_RESPONSE) && (offer.getStatus() != OfferStatusEnum.REJECTED)) {

            return "redirect:/offers/detail/" + id;
        }

        return null; // Trả về null nếu không có gì cần redirect
    }
}
