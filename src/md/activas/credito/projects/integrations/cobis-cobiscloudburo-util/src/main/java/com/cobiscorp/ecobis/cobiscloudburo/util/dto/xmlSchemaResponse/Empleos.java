package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class Empleos {
    private List<Empleo> empleosList;

    public List<Empleo> getEmpleosList() {
        return empleosList;
    }

    @XmlElement(name = "Empleo")
    public void setEmpleosList(List<Empleo> empleosList) {
        this.empleosList = empleosList;
    }

    @Override
    public String toString() {
        return "Empleos{" +
                "empleosList=" + empleosList +
                '}';
    }

}
