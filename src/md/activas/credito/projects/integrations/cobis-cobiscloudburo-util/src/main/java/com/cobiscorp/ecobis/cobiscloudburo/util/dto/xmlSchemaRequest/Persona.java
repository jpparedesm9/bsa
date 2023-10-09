package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 11/07/2017.
 */
public class Persona {
    private Encabezado encabezado;
    private Nombre nombre;
    private Domicilios domicilios;

    public Encabezado getEncabezado() {
        return encabezado;
    }

    @XmlElement(name = "Encabezado")
    public void setEncabezado(Encabezado encabezado) {
        this.encabezado = encabezado;
    }

    public Nombre getNombre() {
        return nombre;
    }

    @XmlElement(name = "Nombre")
    public void setNombre(Nombre nombre) {
        this.nombre = nombre;
    }

    public Domicilios getDomicilios() {
        return domicilios;
    }

    @XmlElement(name = "Domicilios")
    public void setDomicilios(Domicilios domicilios) {
        this.domicilios = domicilios;
    }
}
