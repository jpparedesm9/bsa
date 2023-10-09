package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;
import java.util.List;

public class Cuentas {
    private List<Cuenta> cuentasList;

    public List<Cuenta> getCuentasList() {
        return cuentasList;
    }

    @XmlElement(name = "Cuenta")
    public void setCuentasList(List<Cuenta> cuentasList) {
        this.cuentasList = cuentasList;
    }

    @Override
    public String toString() {
        return "Cuentas{" +
                "cuentasList=" + cuentasList +
                '}';
    }
}
