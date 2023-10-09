package com.cobiscorp.ecobis.cloud.service.dto.address;

public class PhoneResult {

    private int phoneId;

    public PhoneResult(Integer phoneId) {
        this.phoneId = phoneId;
    }

    public PhoneResult() {
    }

    public int getPhoneId() {
        return phoneId;
    }

    public void setPhoneId(int phoneId) {
        this.phoneId = phoneId;
    }
}
