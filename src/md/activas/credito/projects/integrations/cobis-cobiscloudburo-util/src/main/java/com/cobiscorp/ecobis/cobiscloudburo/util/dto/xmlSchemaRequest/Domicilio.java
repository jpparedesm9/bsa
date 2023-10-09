package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest;

import javax.xml.bind.annotation.XmlElement;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class Domicilio {
    private String direccion1;
    private String coloniaPoblacion;
    private String delegacionMunicipio;
    private String ciudad;
    private String estado;
    private String cP;
    private String codPais;

    public Domicilio(){

    }

    public String getDireccion1() {
        return direccion1;
    }

    @XmlElement(name = "Direccion1")
    public void setDireccion1(String direccion1) {
        this.direccion1 = setMaximumLength(direccion1, 40);
    }

    public String getColoniaPoblacion() {
        return coloniaPoblacion;
    }

    @XmlElement(name = "ColoniaPoblacion")
    public void setColoniaPoblacion(String coloniaPoblacion) {
        this.coloniaPoblacion = setMaximumLength(coloniaPoblacion, 40);
    }

    public String getDelegacionMunicipio() {
        return delegacionMunicipio;
    }

    @XmlElement(name = "DelegacionMunicipio")
    public void setDelegacionMunicipio(String delegacionMunicipio) {
        this.delegacionMunicipio = setMaximumLength(delegacionMunicipio, 40);
    }

    public String getCiudad() {
        return ciudad;
    }

    @XmlElement(name = "Ciudad")
    public void setCiudad(String ciudad) {
        this.ciudad = setMaximumLength(ciudad, 40);
    }

    public String getEstado() {
        return estado;
    }

    @XmlElement(name = "Estado")
    public void setEstado(String estado) {
        this.estado = setMaximumLength(estado, 4);
    }

    public String getcP() {
        return cP;
    }

    @XmlElement(name = "CP")
    public void setcP(String cP) {
        this.cP = setMaximumLength(cP, 5);
    }

    public String getCodPais() {
        return codPais;
    }

    @XmlElement(name = "CodPais")
    public void setCodPais(String codPais) {
        this.codPais = setMaximumLength(codPais, 2);
    }

    private String setMaximumLength(String information, int length) {
        return information != null ? (information.length() > length ? information.substring(0, length) : information) : information;
    }
}
