package com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * Created by farid on 7/24/2017.
 */
public class SolidarityPaymentResponse {
    private ServiceResponse reference;

    public SolidarityPaymentResponse() {
    }

    public SolidarityPaymentResponse(ServiceResponse reference) {
        this.reference = reference;
    }

    public ServiceResponse getReference() {
        return reference;
    }

    public void setReference(ServiceResponse reference) {
        this.reference = reference;
    }
}
