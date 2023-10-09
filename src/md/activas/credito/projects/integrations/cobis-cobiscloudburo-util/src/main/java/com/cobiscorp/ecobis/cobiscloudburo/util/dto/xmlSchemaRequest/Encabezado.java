package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class Encabezado {
    private String version;
    private String numeroReferenciaOperador;
    private String productoRequerido;
    private String clavePais;
    private String claveUsuario;
    private String password;
    private String tipoConsulta;
    private String tipoContrato;
    private String claveUnidadMonetaria;
    private String importeContrato;
    private String idioma;
    private String tipoSalida;

    public Encabezado() {

    }

    public String getVersion() {
        return version;
    }

    @XmlElement(name = "Version")
    public void setVersion(String version) {
        this.version = setMaximumLength(version, 2);
    }

    public String getNumeroReferenciaOperador() {
        return numeroReferenciaOperador;
    }

    @XmlElement(name = "NumeroReferenciaOperador")
    public void setNumeroReferenciaOperador(String numeroReferenciaOperador) {
        this.numeroReferenciaOperador = setMaximumLength(numeroReferenciaOperador, 25);
    }

    public String getProductoRequerido() {
        return productoRequerido;
    }

    @XmlElement(name = "ProductoRequerido")
    public void setProductoRequerido(String productoRequerido) {
        this.productoRequerido = setMaximumLength(productoRequerido, 3);
    }

    public String getClavePais() {
        return clavePais;
    }

    @XmlElement(name = "ClavePais")
    public void setClavePais(String clavePais) {
        this.clavePais = setMaximumLength(clavePais, 2);
    }

    public String getClaveUsuario() {
        return claveUsuario;
    }

    @XmlElement(name = "ClaveUsuario")
    public void setClaveUsuario(String claveUsuario) {
        this.claveUsuario = setMaximumLength(claveUsuario, 10);
    }

    public String getPassword() {
        return password;
    }

    @XmlElement(name = "Password")
    public void setPassword(String password) {
        this.password = setMaximumLength(password, 8);
    }

    public String getTipoConsulta() {
        return tipoConsulta;
    }

    @XmlElement(name = "TipoConsulta")
    public void setTipoConsulta(String tipoConsulta) {
        this.tipoConsulta = setMaximumLength(tipoConsulta, 1);
    }

    public String getTipoContrato() {
        return tipoContrato;
    }

    @XmlElement(name = "TipoContrato")
    public void setTipoContrato(String tipoContrato) {
        this.tipoContrato = setMaximumLength(tipoContrato, 2);
    }

    public String getClaveUnidadMonetaria() {
        return claveUnidadMonetaria;
    }

    @XmlElement(name = "ClaveUnidadMonetaria")
    public void setClaveUnidadMonetaria(String claveUnidadMonetaria) {
        this.claveUnidadMonetaria = setMaximumLength(claveUnidadMonetaria, 2);
    }

    public String getImporteContrato() {
        return importeContrato;
    }

    @XmlElement(name = "ImporteContrato")
    public void setImporteContrato(String importeContrato) {
        this.importeContrato = setMaximumLength(importeContrato, 9);
    }

    public String getIdioma() {
        return idioma;
    }

    @XmlElement(name = "Idioma")
    public void setIdioma(String idioma) {
        this.idioma = setMaximumLength(idioma, 2);
    }

    public String getTipoSalida() {
        return tipoSalida;
    }

    @XmlElement(name = "TipoSalida")
    public void setTipoSalida(String tipoSalida) {
        this.tipoSalida = setMaximumLength(tipoSalida, 2);
    }

    private String setMaximumLength(String information, int length) {
        return information != null ? (information.length() > length ? information.substring(0, length) : information) : information;
    }
}
