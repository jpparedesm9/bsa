package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 11/07/2017.
 */
public class Personas {
    private Persona persona;

    public Persona getPersona() {
        return persona;
    }

    @XmlElement(name = "Persona")
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
}
