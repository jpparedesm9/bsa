package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.common.OutputData;

public class SpouseDataResponse implements OutputData {

    private ServiceResponse spouse;
    private ServiceResponse additional;
    private ServiceResponse economicActivity;
    
    public SpouseDataResponse() {
    }

    public SpouseDataResponse(ServiceResponse spouse, ServiceResponse additional) {
        this.spouse = spouse;
        this.additional = additional;
    }

    public ServiceResponse getSpouse() {
        return spouse;
    }

    public void setSpouse(ServiceResponse spouse) {
        this.spouse = spouse;
    }

    public ServiceResponse getAdditional() {
        return additional;
    }

    public void setAdditional(ServiceResponse additional) {
        this.additional = additional;
    }

    public void setEconomicActivity(ServiceResponse economicActivity) {
	this.economicActivity = economicActivity;
    }

    public ServiceResponse getEconomicActivity() {
	return economicActivity;
    }
    
    @Override
    public ServiceResponse[] getResponses() {
        return new ServiceResponse[]{spouse, additional, economicActivity};
    }
}
