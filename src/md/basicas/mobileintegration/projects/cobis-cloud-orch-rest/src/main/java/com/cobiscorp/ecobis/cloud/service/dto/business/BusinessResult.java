package com.cobiscorp.ecobis.cloud.service.dto.business;

public class BusinessResult {
    private int businessId;
    private int phoneId;

    public BusinessResult(Integer businessId, Integer phoneId) {
        this.businessId = businessId == null ? 0 : businessId;
        this.phoneId = phoneId == null ? 0 : phoneId;
    }

    public int getBusinessId() {
        return businessId;
    }
    
    public int getPhoneId() {
        return phoneId;
    }

    public void setBusinessId(int businessId) {
        this.businessId = businessId;
    }
    
    public void setPhoneId(int phoneId) {
        this.phoneId = phoneId;
    }
}
