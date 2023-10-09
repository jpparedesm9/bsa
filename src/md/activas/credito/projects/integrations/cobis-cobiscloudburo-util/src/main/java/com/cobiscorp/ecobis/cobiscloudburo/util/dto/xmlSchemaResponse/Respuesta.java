package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by pclavijo on 13/07/2017.
 */
@XmlRootElement(name = "Respuesta")
public class Respuesta {
    private Personas personas;

    public Personas getPersonas() {
        return personas;
    }

    @XmlElement(name = "Personas")
    public void setPersonas(Personas personas) {
        this.personas = personas;
    }

    @Override
    public String toString() {
        return "Respuesta{" +
                "personas=" + personas +
                '}';
    }
}
