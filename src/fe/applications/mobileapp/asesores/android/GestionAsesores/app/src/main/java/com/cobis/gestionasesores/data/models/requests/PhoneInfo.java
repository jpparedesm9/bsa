package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by bqtdesa02 on 7/27/2017.
 */

public class PhoneInfo {

    private int phoneId;
    private String number;
    private String areaCode;

    public int getPhoneId() {
        return phoneId;
    }

    public void setPhoneId(int phoneId) {
        this.phoneId = phoneId;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }
}
