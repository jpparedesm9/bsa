package com.cobis.cloud.sofom.referencedata.party.santander.dto;

public class CustomerByBucRequest {
    private String numeroPersona;

    public CustomerByBucRequest() {
    }

    public CustomerByBucRequest(String numeroPersona) {
        this.numeroPersona = numeroPersona;
    }

    public String getNumeroPersona() {
        return numeroPersona;
    }

    public void setNumeroPersona(String numeroPersona) {
        this.numeroPersona = numeroPersona;
    }
}
