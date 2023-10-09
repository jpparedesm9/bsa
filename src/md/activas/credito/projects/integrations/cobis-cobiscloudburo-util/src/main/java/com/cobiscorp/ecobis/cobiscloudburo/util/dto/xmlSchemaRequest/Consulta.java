package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by pclavijo on 11/07/2017.
 */
@XmlRootElement(name = "Consulta")
public class Consulta {
    private Personas personas;

    public Personas getPersonas() {
        return personas;
    }

    @XmlElement(name = "Personas")
    public void setPersonas(Personas personas) {
        this.personas = personas;
    }
}
