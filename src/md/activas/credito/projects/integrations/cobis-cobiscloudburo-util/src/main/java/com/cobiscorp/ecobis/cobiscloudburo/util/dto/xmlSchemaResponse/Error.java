package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

/**
 * Created by pclavijo on 13/07/2017.
 */
public class Error {
    private AR ar;
    private UR ur;

    public AR getAr() {
        return ar;
    }

    @XmlElement(name = "AR")
    public void setAr(AR ar) {
        this.ar = ar;
    }

    public UR getUr() {
        return ur;
    }

    @XmlElement(name = "UR")
    public void setUr(UR ur) {
        this.ur = ur;
    }

    @Override
    public String toString() {
        return "Error{" +
                "ar=" + ar +
                ", ur=" + ur +
                '}';
    }
}
