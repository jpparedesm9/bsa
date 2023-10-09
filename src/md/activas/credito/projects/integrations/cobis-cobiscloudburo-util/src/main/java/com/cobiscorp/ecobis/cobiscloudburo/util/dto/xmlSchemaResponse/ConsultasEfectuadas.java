package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class ConsultasEfectuadas {
    private List<ConsultaEfectuada> consultasEfectuadasList;

    public List<ConsultaEfectuada> getConsultasEfectuadasList() {
        return consultasEfectuadasList;
    }

    @XmlElement(name = "ConsultaEfectuada")
    public void setConsultasEfectuadasList(List<ConsultaEfectuada> consultasEfectuadasList) {
        this.consultasEfectuadasList = consultasEfectuadasList;
    }

    @Override
    public String toString() {
        return "ConsultasEfectuadas{" +
                "consultasEfectuadasList=" + consultasEfectuadasList +
                '}';
    }
}
