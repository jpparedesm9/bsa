package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 11/07/2017.
 */
public class Domicilios {
    private Domicilio domicilio;

    public Domicilio getDomicilio() {
        return domicilio;
    }

    @XmlElement(name = "Domicilio")
    public void setDomicilio(Domicilio domicilio) {
        this.domicilio = domicilio;
    }
}
