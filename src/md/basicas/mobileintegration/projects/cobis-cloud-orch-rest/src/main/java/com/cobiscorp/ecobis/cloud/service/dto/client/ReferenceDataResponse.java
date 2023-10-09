package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class ReferenceDataResponse {
    private ServiceResponse reference;

    public ReferenceDataResponse() {
    }

    public ReferenceDataResponse(ServiceResponse reference) {
        this.reference = reference;
    }

    public ServiceResponse getReference() {
        return reference;
    }

    public void setReference(ServiceResponse reference) {
        this.reference = reference;
    }
}
