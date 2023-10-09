package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class ResumenReportes {
    private List<ResumenReporte> resumenReportesList;

    public List<ResumenReporte> getResumenReportesList() {
        return resumenReportesList;
    }

    @XmlElement(name = "ResumenReporte")
    public void setResumenReportesList(List<ResumenReporte> resumenReportesList) {
        this.resumenReportesList = resumenReportesList;
    }

    @Override
    public String toString() {
        return "ResumenReportes{" +
                "resumenReportesList=" + resumenReportesList +
                '}';
    }
}
