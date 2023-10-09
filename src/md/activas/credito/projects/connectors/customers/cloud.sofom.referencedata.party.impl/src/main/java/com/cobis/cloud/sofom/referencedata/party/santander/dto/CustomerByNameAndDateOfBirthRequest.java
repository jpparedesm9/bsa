package com.cobis.cloud.sofom.referencedata.party.santander.dto;

public class CustomerByNameAndDateOfBirthRequest {
    private String primerApellido;
    private String segundoApellido;
    private String nombrePersona;
    private String fechaNacimiento;

    public CustomerByNameAndDateOfBirthRequest() {
    }

    public CustomerByNameAndDateOfBirthRequest(String primerApellido, String segundoApellido, String nombrePersona, String fechaNacimiento) {
        this.primerApellido = primerApellido;
        this.segundoApellido = segundoApellido;
        this.nombrePersona = nombrePersona;
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getPrimerApellido() {
        return primerApellido;
    }

    public void setPrimerApellido(String primerApellido) {
        this.primerApellido = primerApellido;
    }

    public String getSegundoApellido() {
        return segundoApellido;
    }

    public void setSegundoApellido(String segundoApellido) {
        this.segundoApellido = segundoApellido;
    }

    public String getNombrePersona() {
        return nombrePersona;
    }

    public void setNombrePersona(String nombrePersona) {
        this.nombrePersona = nombrePersona;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
}
