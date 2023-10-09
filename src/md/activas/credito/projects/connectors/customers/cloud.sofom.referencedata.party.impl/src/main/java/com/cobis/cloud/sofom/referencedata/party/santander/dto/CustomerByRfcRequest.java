package com.cobis.cloud.sofom.referencedata.party.santander.dto;

public class CustomerByRfcRequest {
    private String rfc;
    private String indicadorMasDatos;

    public CustomerByRfcRequest() {
    }

    public CustomerByRfcRequest(String rfc, String indicadorMasDatos) {
        this.rfc = rfc;
        this.indicadorMasDatos = indicadorMasDatos;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getIndicadorMasDatos() {
        return indicadorMasDatos;
    }

    public void setIndicadorMasDatos(String indicadorMasDatos) {
        this.indicadorMasDatos = indicadorMasDatos;
    }
}
