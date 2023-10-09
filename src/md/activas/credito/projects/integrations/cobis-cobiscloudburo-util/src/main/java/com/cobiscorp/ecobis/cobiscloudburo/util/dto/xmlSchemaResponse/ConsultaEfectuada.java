package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

public class ConsultaEfectuada {
    private String fechaConsulta;
    private String identificacionBuro;
    private String claveOtorgante;
    private String nombreOtorgante;
    private String telefonoOtorgante;
    private String tipoContrato;
    private String claveUnidadMonetaria;
    private String importeContrato;
    private String indicadorTipoResponsabilidad;
    private String consumidorNuevo;
    private String resultadoFinal;
    private String identificadorOrigenConsulta;


    public String getFechaConsulta() {
        return fechaConsulta;
    }

    @XmlElement(name = "FechaConsulta")
    public void setFechaConsulta(String fechaConsulta) {
        this.fechaConsulta = fechaConsulta;
    }

    public String getIdentificacionBuro() {
        return identificacionBuro;
    }

    @XmlElement(name = "IdentificacionBuro")
    public void setIdentificacionBuro(String identificacionBuro) {
        this.identificacionBuro = identificacionBuro;
    }

    public String getClaveOtorgante() {
        return claveOtorgante;
    }

    @XmlElement(name = "ClaveOtorgante")
    public void setClaveOtorgante(String claveOtorgante) {
        this.claveOtorgante = claveOtorgante;
    }

    public String getNombreOtorgante() {
        return nombreOtorgante;
    }

    @XmlElement(name = "NombreOtorgante")
    public void setNombreOtorgante(String nombreOtorgante) {
        this.nombreOtorgante = nombreOtorgante;
    }

    public String getTelefonoOtorgante() {
        return telefonoOtorgante;
    }

    @XmlElement(name = "TelefonoOtorgante")
    public void setTelefonoOtorgante(String telefonoOtorgante) {
        this.telefonoOtorgante = telefonoOtorgante;
    }

    public String getTipoContrato() {
        return tipoContrato;
    }

    @XmlElement(name = "TipoContrato")
    public void setTipoContrato(String tipoContrato) {
        this.tipoContrato = tipoContrato;
    }

    public String getClaveUnidadMonetaria() {
        return claveUnidadMonetaria;
    }

    @XmlElement(name = "ClaveUnidadMonetaria")
    public void setClaveUnidadMonetaria(String claveUnidadMonetaria) {
        this.claveUnidadMonetaria = claveUnidadMonetaria;
    }

    public String getImporteContrato() {
        return importeContrato;
    }

    @XmlElement(name = "ImporteContrato")
    public void setImporteContrato(String importeContrato) {
        this.importeContrato = importeContrato;
    }

    public String getIndicadorTipoResponsabilidad() {
        return indicadorTipoResponsabilidad;
    }

    @XmlElement(name = "IndicadorTipoResponsabilidad")
    public void setIndicadorTipoResponsabilidad(String indicadorTipoResponsabilidad) {
        this.indicadorTipoResponsabilidad = indicadorTipoResponsabilidad;
    }

    public String getConsumidorNuevo() {
        return consumidorNuevo;
    }

    @XmlElement(name = "ConsumidorNuevo")
    public void setConsumidorNuevo(String consumidorNuevo) {
        this.consumidorNuevo = consumidorNuevo;
    }

    public String getResultadoFinal() {
        return resultadoFinal;
    }

    @XmlElement(name = "ResultadoFinal")
    public void setResultadoFinal(String resultadoFinal) {
        this.resultadoFinal = resultadoFinal;
    }

    public String getIdentificadorOrigenConsulta() {
        return identificadorOrigenConsulta;
    }

    @XmlElement(name = "IdentificadorOrigenConsulta")
    public void setIdentificadorOrigenConsulta(String identificadorOrigenConsulta) {
        this.identificadorOrigenConsulta = identificadorOrigenConsulta;
    }

    @Override
    public String toString() {
        return "ConsultaEfectuada{" +
                "fechaConsulta='" + fechaConsulta + '\'' +
                ", identificacionBuro='" + identificacionBuro + '\'' +
                ", claveOtorgante='" + claveOtorgante + '\'' +
                ", nombreOtorgante='" + nombreOtorgante + '\'' +
                ", telefonoOtorgante='" + telefonoOtorgante + '\'' +
                ", tipoContrato='" + tipoContrato + '\'' +
                ", claveUnidadMonetaria='" + claveUnidadMonetaria + '\'' +
                ", importeContrato='" + importeContrato + '\'' +
                ", indicadorTipoResponsabilidad='" + indicadorTipoResponsabilidad + '\'' +
                ", consumidorNuevo='" + consumidorNuevo + '\'' +
                ", resultadoFinal='" + resultadoFinal + '\'' +
                ", identificadorOrigenConsulta='" + identificadorOrigenConsulta + '\'' +
                '}';
    }
}
