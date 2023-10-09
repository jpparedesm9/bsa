package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class Nombre {
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String primerNombre;
    private String segundoNombre;
    private String fechaNacimiento;
    private String rFC;

    public Nombre(){

    }

    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    @XmlElement(name = "ApellidoPaterno")
    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = setMaximumLength(apellidoPaterno, 26);
    }

    public String getApellidoMaterno() {
        return apellidoMaterno;
    }

    @XmlElement(name = "ApellidoMaterno")
    public void setApellidoMaterno(String apellidoMaterno) {
        this.apellidoMaterno = setMaximumLength(apellidoMaterno, 26);
    }

    public String getPrimerNombre() {
        return primerNombre;
    }

    @XmlElement(name = "PrimerNombre")
    public void setPrimerNombre(String primerNombre) {
        this.primerNombre = setMaximumLength(primerNombre, 26);
    }

    public String getSegundoNombre() {
        return segundoNombre;
    }

    @XmlElement(name = "SegundoNombre")
    public void setSegundoNombre(String segundoNombre) {
        this.segundoNombre = setMaximumLength(segundoNombre, 26);
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    @XmlElement(name = "FechaNacimiento")
    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = setMaximumLength(fechaNacimiento, 8);
    }

    public String getrFC() {
        return rFC;
    }

    @XmlElement(name = "RFC")
    public void setrFC(String rFC) {
        this.rFC = setMaximumLength(rFC, 13);
    }

    private String setMaximumLength(String information, int length) {
        return information != null ? (information.length() > length ? information.substring(0, length) : information) : information;
    }

}
