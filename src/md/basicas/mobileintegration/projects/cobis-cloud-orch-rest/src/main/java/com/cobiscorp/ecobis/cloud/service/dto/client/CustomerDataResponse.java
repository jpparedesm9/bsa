package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class CustomerDataResponse{

    private ServiceResponse customer;

    public CustomerDataResponse() {
    }

    public CustomerDataResponse(ServiceResponse customerResponse) {
        this.customer = customerResponse;
    }

    public ServiceResponse getCustomer() {
        return customer;
    }

    public void setCustomer(ServiceResponse customer) {
        this.customer = customer;
    }
}
