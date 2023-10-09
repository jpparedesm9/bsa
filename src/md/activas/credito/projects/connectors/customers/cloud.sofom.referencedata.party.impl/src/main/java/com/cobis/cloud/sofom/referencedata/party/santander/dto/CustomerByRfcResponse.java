package com.cobis.cloud.sofom.referencedata.party.santander.dto;

/**
 * Created by pclavijo on 20/06/2017.
 */
public class CustomerByRfcResponse {
    private String tipoCliente;
    private String numeroPersona;
    private String nombre;
    private String fechaNacimiento;
    private String rfc;
    private String domicilio;
    private String indicadorAlta;
    private String bucReposicionamiento;
    private String indicadorMasDatos;
    private String codigoRetorno;
    private String codigoErrorAltair;
    private String codigoGenRutina;

    public CustomerByRfcResponse() {
    }

    public CustomerByRfcResponse(String tipoCliente, String numeroPersona, String nombre, String fechaNacimiento, String rfc, String domicilio, String indicadorAlta, String bucReposicionamiento, String indicadorMasDatos, String codigoRetorno, String codigoErrorAltair, String codigoGenRutina) {
        this.tipoCliente = tipoCliente;
        this.numeroPersona = numeroPersona;
        this.nombre = nombre;
        this.fechaNacimiento = fechaNacimiento;
        this.rfc = rfc;
        this.domicilio = domicilio;
        this.indicadorAlta = indicadorAlta;
        this.bucReposicionamiento = bucReposicionamiento;
        this.indicadorMasDatos = indicadorMasDatos;
        this.codigoRetorno = codigoRetorno;
        this.codigoErrorAltair = codigoErrorAltair;
        this.codigoGenRutina = codigoGenRutina;
    }

    public String getTipoCliente() {
        return tipoCliente;
    }

    public void setTipoCliente(String tipoCliente) {
        this.tipoCliente = tipoCliente;
    }

    public String getNumeroPersona() {
        return numeroPersona;
    }

    public void setNumeroPersona(String numeroPersona) {
        this.numeroPersona = numeroPersona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio = domicilio;
    }

    public String getIndicadorAlta() {
        return indicadorAlta;
    }

    public void setIndicadorAlta(String indicadorAlta) {
        this.indicadorAlta = indicadorAlta;
    }

    public String getBucReposicionamiento() {
        return bucReposicionamiento;
    }

    public void setBucReposicionamiento(String bucReposicionamiento) {
        this.bucReposicionamiento = bucReposicionamiento;
    }

    public String getIndicadorMasDatos() {
        return indicadorMasDatos;
    }

    public void setIndicadorMasDatos(String indicadorMasDatos) {
        this.indicadorMasDatos = indicadorMasDatos;
    }

    public String getCodigoRetorno() {
        return codigoRetorno;
    }

    public void setCodigoRetorno(String codigoRetorno) {
        this.codigoRetorno = codigoRetorno;
    }

    public String getCodigoErrorAltair() {
        return codigoErrorAltair;
    }

    public void setCodigoErrorAltair(String codigoErrorAltair) {
        this.codigoErrorAltair = codigoErrorAltair;
    }

    public String getCodigoGenRutina() {
        return codigoGenRutina;
    }

    public void setCodigoGenRutina(String codigoGenRutina) {
        this.codigoGenRutina = codigoGenRutina;
    }
}
