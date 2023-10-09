package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 11/07/2017.
 */
public class Persona {
    private Encabezado encabezado;
    private Cuentas cuentas;
    private ResumenReportes resumenReportes;
    private ScoreBuroCredito scoreBuroCredito;
    private Empleos empleos;
    private ConsultasEfectuadas consultasEfectuadas;
    private Error error;
    private Domicilios domicilios;

    public Cuentas getCuentas() {
        return cuentas;
    }

    @XmlElement(name = "Cuentas")
    public void setCuentas(Cuentas cuentas) {
        this.cuentas = cuentas;
    }

    public ScoreBuroCredito getScoreBuroCredito() {
        return scoreBuroCredito;
    }

    @XmlElement(name = "ScoreBuroCredito")
    public void setScoreBuroCredito(ScoreBuroCredito scoreBuroCredito) {
        this.scoreBuroCredito = scoreBuroCredito;
    }

    public Error getError() {
        return error;
    }

    @XmlElement(name = "Error")
    public void setError(Error error) {
        this.error = error;
    }

    public ResumenReportes getResumenReportes() {
        return resumenReportes;
    }

    @XmlElement(name = "ResumenReporte")
    public void setResumenReportes(ResumenReportes resumenReportes) {
        this.resumenReportes = resumenReportes;
    }

    public Empleos getEmpleos() {
        return empleos;
    }

    @XmlElement(name = "Empleos")
    public void setEmpleos(Empleos empleos) {
        this.empleos = empleos;
    }

    public ConsultasEfectuadas getConsultasEfectuadas() {
        return consultasEfectuadas;
    }

    @XmlElement(name = "ConsultasEfectuadas")
    public void setConsultasEfectuadas(ConsultasEfectuadas consultasEfectuadas) {
        this.consultasEfectuadas = consultasEfectuadas;
    }

    public Encabezado getEncabezado() {
        return encabezado;
    }

    @XmlElement(name = "Encabezado")
    public void setEncabezado(Encabezado encabezado) {
        this.encabezado = encabezado;
    }

    public Domicilios getDomicilios() {
        return domicilios;
    }

    @XmlElement(name = "Domicilios")
    public void setDomicilios(Domicilios domicilios) {
        this.domicilios = domicilios;
    }

    @Override
    public String toString() {
        return "Persona{" +
                "cuentas=" + cuentas +
                ", resumenReportes=" + resumenReportes +
                ", scoreBuroCredito=" + scoreBuroCredito +
                ", error=" + error +
                ", empleos=" + empleos +
                ", consultasEfectuadas=" + consultasEfectuadas +
                ", encabezado=" + encabezado +
                ", direcciones=" + domicilios +
                '}';
    }
}
