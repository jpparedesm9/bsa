package com.cobis.cloud.sofom.referencedata.party.dto;

/**
 * Created by pclavijo on 20/06/2017.
 */
public class CustomerInfo {
    private String buc;
    private String status;

    public CustomerInfo(String buc, String status) {
        this.buc = buc;
        this.status = status;
    }

    public String getBuc() {
        return buc;
    }

    public void setBuc(String buc) {
        this.buc = buc;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CustomerInfo{" +
                "buc='" + buc + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
