package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 13/07/2017.
 */
public class AR {
    private String sujetoNoAutenticado;
    private String claveOPasswordErroneo;
    private String errorSistemaBC;
    private String etiquetaSegmentoErronea;
    private String faltaCampoRequerido;
    private String errorReporteBloqueado;

    public String getSujetoNoAutenticado() {
        return sujetoNoAutenticado;
    }

    @XmlElement(name = "SujetoNoAutenticado")
    public void setSujetoNoAutenticado(String sujetoNoAutenticado) {
        this.sujetoNoAutenticado = sujetoNoAutenticado;
    }

    public String getClaveOPasswordErroneo() {
        return claveOPasswordErroneo;
    }

    @XmlElement(name = "ClaveOPasswordErroneo")
    public void setClaveOPasswordErroneo(String claveOPasswordErroneo) {
        this.claveOPasswordErroneo = claveOPasswordErroneo;
    }

    public String getErrorSistemaBC() {
        return errorSistemaBC;
    }

    @XmlElement(name = "ErrorSistemaBC")
    public void setErrorSistemaBC(String errorSistemaBC) {
        this.errorSistemaBC = errorSistemaBC;
    }

    public String getEtiquetaSegmentoErronea() {
        return etiquetaSegmentoErronea;
    }

    @XmlElement(name = "EtiquetaSegmentoErronea")
    public void setEtiquetaSegmentoErronea(String etiquetaSegmentoErronea) {
        this.etiquetaSegmentoErronea = etiquetaSegmentoErronea;
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
        return "AR{" +
                "sujetoNoAutenticado='" + sujetoNoAutenticado + '\'' +
                ", claveOPasswordErroneo='" + claveOPasswordErroneo + '\'' +
                ", errorSistemaBC='" + errorSistemaBC + '\'' +
                ", etiquetaSegmentoErronea='" + etiquetaSegmentoErronea + '\'' +
                ", faltaCampoRequerido='" + faltaCampoRequerido + '\'' +
                ", errorReporteBloqueado='" + errorReporteBloqueado + '\'' +
                '}';
    }
}
