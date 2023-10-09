package com.cobis.tuiiob2c.data.models.requests;

public class OtpLoanRequest {

    private String otp;

    public OtpLoanRequest(String otp) {
        this.otp = otp;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }
}
