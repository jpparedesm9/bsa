package com.cobiscorp.ecobis.cobiscloudsecurity.rest.util;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * @author Cesar Loachamin
 */
public class IntegrationException extends RuntimeException {

    private ServiceResponse response;

    public IntegrationException(ServiceResponse response) {
        this.response = response;
    }

    public ServiceResponse getResponse() {
        return response;
    }
}
