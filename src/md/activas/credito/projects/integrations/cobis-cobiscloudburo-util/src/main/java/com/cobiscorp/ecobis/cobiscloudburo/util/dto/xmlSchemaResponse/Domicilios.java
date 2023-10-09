package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class Domicilios {

    private List<Domicilio> domiciliosList;

    public List<Domicilio> getDomiciliosList() {
        return domiciliosList;
    }

    @XmlElement(name = "Domicilio")
    public void setDomiciliosList(List<Domicilio> domiciliosList) {
        this.domiciliosList = domiciliosList;
    }

    @Override
    public String toString() {
        return "Domicilios{" +
                "domiciliosList=" + domiciliosList +
                '}';
    }

}
