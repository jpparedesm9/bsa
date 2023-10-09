package com.cobiscorp.ecobis.cloud.service.dto.business;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.common.OutputData;

public class BusinessDataResponse implements OutputData {

    private ServiceResponse business;
    private ServiceResponse address;
    private ServiceResponse geoReference;

    public BusinessDataResponse(ServiceResponse business) {
	this.business = business;
    }

    public BusinessDataResponse() {}

    public ServiceResponse getBusiness() {
	return business;
    }

    public void setBusiness(ServiceResponse business) {
	this.business = business;
    }

    public void setAddress(ServiceResponse address) {
	this.address = address;
    }

    public ServiceResponse getAddress() {
	return address;
    }

    public void setGeoReference(ServiceResponse geoReference) {
	this.geoReference = geoReference;
    }

    public ServiceResponse getGeoReference() {
	return geoReference;
    }

    public ServiceResponse[] getResponses() {
	return new ServiceResponse[] {business, address, geoReference};
    }
}
