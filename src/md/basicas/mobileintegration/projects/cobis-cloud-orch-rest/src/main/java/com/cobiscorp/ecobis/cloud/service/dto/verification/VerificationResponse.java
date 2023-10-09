package com.cobiscorp.ecobis.cloud.service.dto.verification;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class VerificationResponse {

    private ServiceResponse verification;

    public ServiceResponse getVerification() {
        return verification;
    }

    public void setVerification(ServiceResponse verification) {
        this.verification = verification;
    }
}
