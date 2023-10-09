package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 13/07/2017.
 */
public class UR {
    private String numeroReferenciaOperador;
    private String solicitudClienteErronea;
    private String versionProporcionadaErronea;
    private String productoSolicitadoErroneo;
    private String passwordOClaveErronea;
    private String segmentoRequeridoNoProporcionado;
    private String ultimaInformacionValidaCliente;
    private String informacionErroneaParaConsulta;
    private String valorErroneoCampoRelacionado;
    private String errorSistemaBuroCredito;
    private String etiquetaSegmentoErronea;
    private String ordenErroneoSegmento;
    private String numeroErroneoSegmentos;
    private String faltaCampoRequerido;
    private String errorReporteBloqueado;

    public String getNumeroReferenciaOperador() {
        return numeroReferenciaOperador;
    }

    @XmlElement(name = "NumeroReferenciaOperador")
    public void setNumeroReferenciaOperador(String numeroReferenciaOperador) {
        this.numeroReferenciaOperador = numeroReferenciaOperador;
    }

    public String getSolicitudClienteErronea() {
        return solicitudClienteErronea;
    }

    @XmlElement(name = "SolicitudClienteErronea")
    public void setSolicitudClienteErronea(String solicitudClienteErronea) {
        this.solicitudClienteErronea = solicitudClienteErronea;
    }

    public String getVersionProporcionadaErronea() {
        return versionProporcionadaErronea;
    }

    @XmlElement(name = "VersionProporcionadaErronea")
    public void setVersionProporcionadaErronea(String versionProporcionadaErronea) {
        this.versionProporcionadaErronea = versionProporcionadaErronea;
    }

    public String getProductoSolicitadoErroneo() {
        return productoSolicitadoErroneo;
    }

    @XmlElement(name = "ProductoSolicitadoErroneo")
    public void setProductoSolicitadoErroneo(String productoSolicitadoErroneo) {
        this.productoSolicitadoErroneo = productoSolicitadoErroneo;
    }

    public String getPasswordOClaveErronea() {
        return passwordOClaveErronea;
    }

    @XmlElement(name = "PasswordOClaveErronea")
    public void setPasswordOClaveErronea(String passwordOClaveErronea) {
        this.passwordOClaveErronea = passwordOClaveErronea;
    }

    public String getSegmentoRequeridoNoProporcionado() {
        return segmentoRequeridoNoProporcionado;
    }

    @XmlElement(name = "SegmentoRequeridoNoProporcionado")
    public void setSegmentoRequeridoNoProporcionado(String segmentoRequeridoNoProporcionado) {
        this.segmentoRequeridoNoProporcionado = segmentoRequeridoNoProporcionado;
    }

    public String getUltimaInformacionValidaCliente() {
        return ultimaInformacionValidaCliente;
    }

    @XmlElement(name = "UltimaInformacionValidaCliente")
    public void setUltimaInformacionValidaCliente(String ultimaInformacionValidaCliente) {
        this.ultimaInformacionValidaCliente = ultimaInformacionValidaCliente;
    }

    public String getInformacionErroneaParaConsulta() {
        return informacionErroneaParaConsulta;
    }

    @XmlElement(name = "InformacionErroneaParaConsulta")
    public void setInformacionErroneaParaConsulta(String informacionErroneaParaConsulta) {
        this.informacionErroneaParaConsulta = informacionErroneaParaConsulta;
    }

    public String getValorErroneoCampoRelacionado() {
        return valorErroneoCampoRelacionado;
    }

    @XmlElement(name = "ValorErroneoCampoRelacionado")
    public void setValorErroneoCampoRelacionado(String valorErroneoCampoRelacionado) {
        this.valorErroneoCampoRelacionado = valorErroneoCampoRelacionado;
    }

    public String getErrorSistemaBuroCredito() {
        return errorSistemaBuroCredito;
    }

    @XmlElement(name = "ErrorSistemaBuroCredito")
    public void setErrorSistemaBuroCredito(String errorSistemaBuroCredito) {
        this.errorSistemaBuroCredito = errorSistemaBuroCredito;
    }

    public String getEtiquetaSegmentoErronea() {
        return etiquetaSegmentoErronea;
    }

    @XmlElement(name = "EtiquetaSegmentoErronea")
    public void setEtiquetaSegmentoErronea(String etiquetaSegmentoErronea) {
        this.etiquetaSegmentoErronea = etiquetaSegmentoErronea;
    }

    public String getOrdenErroneoSegmento() {
        return ordenErroneoSegmento;
    }

    @XmlElement(name = "OrdenErroneoSegmento")
    public void setOrdenErroneoSegmento(String ordenErroneoSegmento) {
        this.ordenErroneoSegmento = ordenErroneoSegmento;
    }

    public String getNumeroErroneoSegmentos() {
        return numeroErroneoSegmentos;
    }

    @XmlElement(name = "NumeroErroneoSegmentos")
    public void setNumeroErroneoSegmentos(String numeroErroneoSegmentos) {
        this.numeroErroneoSegmentos = numeroErroneoSegmentos;
    }

    public String getFaltaCampoRequerido() {
        return faltaCampoRequerido;
    }

    @XmlElement(name = "FaltaCampoRequerido")
    public void setFaltaCampoRequerido(String faltaCampoRequerido) {
        this.faltaCampoRequerido = faltaCampoRequerido;
    }

    public String getErrorReporteBloqueado() {
        return errorReporteBloqueado;
    }

    @XmlElement(name = "ErrorReporteBloqueado")
    public void setErrorReporteBloqueado(String errorReporteBloqueado) {
        this.errorReporteBloqueado = errorReporteBloqueado;
    }

    @Override
    public String toString() {
        return "UR{" +
                "numeroReferenciaOperador='" + numeroReferenciaOperador + '\'' +
                ", solicitudClienteErronea='" + solicitudClienteErronea + '\'' +
                ", versionProporcionadaErronea='" + versionProporcionadaErronea + '\'' +
                ", productoSolicitadoErroneo='" + productoSolicitadoErroneo + '\'' +
                ", passwordOClaveErronea='" + passwordOClaveErronea + '\'' +
                ", segmentoRequeridoNoProporcionado='" + segmentoRequeridoNoProporcionado + '\'' +
                ", ultimaInformacionValidaCliente='" + ultimaInformacionValidaCliente + '\'' +
                ", informacionErroneaParaConsulta='" + informacionErroneaParaConsulta + '\'' +
                ", valorErroneoCampoRelacionado='" + valorErroneoCampoRelacionado + '\'' +
                ", errorSistemaBuroCredito='" + errorSistemaBuroCredito + '\'' +
                ", etiquetaSegmentoErronea='" + etiquetaSegmentoErronea + '\'' +
                ", ordenErroneoSegmento='" + ordenErroneoSegmento + '\'' +
                ", numeroErroneoSegmentos='" + numeroErroneoSegmentos + '\'' +
                ", faltaCampoRequerido='" + faltaCampoRequerido + '\'' +
                ", errorReporteBloqueado='" + errorReporteBloqueado + '\'' +
                '}';
    }
}
