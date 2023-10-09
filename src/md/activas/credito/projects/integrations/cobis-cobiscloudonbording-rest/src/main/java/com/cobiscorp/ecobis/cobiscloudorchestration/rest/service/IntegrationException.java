package com.cobiscorp.ecobis.cobiscloudorchestration.rest.service;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class IntegrationException extends RuntimeException {

    private ServiceResponse response;

    public IntegrationException(ServiceResponse response) {
        this.response = response;
    }

    public ServiceResponse getResponse() {
        return response;
    }
}