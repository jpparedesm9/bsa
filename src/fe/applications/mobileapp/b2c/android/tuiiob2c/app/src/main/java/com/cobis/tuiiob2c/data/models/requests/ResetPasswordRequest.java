package com.cobis.tuiiob2c.data.models.requests;

public class ResetPasswordRequest {

    private String phone;
    private String password;

    public ResetPasswordRequest() {
    }

    public ResetPasswordRequest(String phone, String password) {
        this.phone = phone;
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
