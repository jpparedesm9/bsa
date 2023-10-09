package com.cobis.tuiiob2c.data.models.requests;

public class OtpVerificationRequest {

    private String pin;

    public OtpVerificationRequest(String pin) {
        this.pin = pin;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }
}
