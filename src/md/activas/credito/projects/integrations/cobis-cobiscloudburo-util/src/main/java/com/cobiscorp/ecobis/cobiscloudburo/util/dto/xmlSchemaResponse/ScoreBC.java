package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 13/07/2017.
 */
public class ScoreBC {
    private String nombreScore;
    private String codigoScore;
    private String valorScore;
    private String codigoRazon;
    private String codigoError;

    public String getNombreScore() {
        return nombreScore;
    }

    @XmlElement(name = "NombreScore")
    public void setNombreScore(String nombreScore) {
        this.nombreScore = nombreScore;
    }

    public String getCodigoScore() {
        return codigoScore;
    }

    @XmlElement(name = "CodigoScore")
    public void setCodigoScore(String codigoScore) {
        this.codigoScore = codigoScore;
    }

    public String getValorScore() {
        return valorScore;
    }

    @XmlElement(name = "ValorScore")
    public void setValorScore(String valorScore) {
        this.valorScore = valorScore;
    }

    public String getCodigoRazon() {
        return codigoRazon;
    }

    @XmlElement(name = "CodigoRazon")
    public void setCodigoRazon(String codigoRazon) {
        this.codigoRazon = codigoRazon;
    }

    public String getCodigoError() {
        return codigoError;
    }

    @XmlElement(name = "CodigoError")
    public void setCodigoError(String codigoError) {
        this.codigoError = codigoError;
    }

    @Override
    public String toString() {
        return "ScoreBC{" +
                "nombreScore='" + nombreScore + '\'' +
                ", codigoScore='" + codigoScore + '\'' +
                ", valorScore='" + valorScore + '\'' +
                ", codigoRazon='" + codigoRazon + '\'' +
                ", codigoError='" + codigoError + '\'' +
                '}';
    }
}
