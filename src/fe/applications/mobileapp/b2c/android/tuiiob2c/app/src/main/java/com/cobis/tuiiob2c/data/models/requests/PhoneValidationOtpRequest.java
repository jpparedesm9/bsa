package com.cobis.tuiiob2c.data.models.requests;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class PhoneValidationOtpRequest {

    @SerializedName("otp")
    @Expose
    private int otp;

    /**
     * No args constructor for use in serialization
     *
     */
    public PhoneValidationOtpRequest() {
    }

    /**
     *
     * @param otp
     */
    public PhoneValidationOtpRequest(int otp) {
        super();
        this.otp = otp;
    }

    public int getOtp() {
        return otp;
    }

    public void setOtp(int otp) {
        this.otp = otp;
    }
}