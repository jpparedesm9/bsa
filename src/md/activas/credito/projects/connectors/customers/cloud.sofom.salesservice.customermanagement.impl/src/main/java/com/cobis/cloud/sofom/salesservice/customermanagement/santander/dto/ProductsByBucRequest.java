package com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto;

public class ProductsByBucRequest {
    private String numeroPersona;
    private String indicador2Llamada;

    public ProductsByBucRequest() {
    }

    public ProductsByBucRequest(String numeroPersona, String indicador2Llamada) {
        this.numeroPersona = numeroPersona;
        this.indicador2Llamada = indicador2Llamada;
    }

    public String getNumeroPersona() {
        return numeroPersona;
    }

    public void setNumeroPersona(String numeroPersona) {
        this.numeroPersona = numeroPersona;
    }

    public String getIndicador2Llamada() {
        return indicador2Llamada;
    }

    public void setIndicador2Llamada(String indicador2Llamada) {
        this.indicador2Llamada = indicador2Llamada;
    }
}
