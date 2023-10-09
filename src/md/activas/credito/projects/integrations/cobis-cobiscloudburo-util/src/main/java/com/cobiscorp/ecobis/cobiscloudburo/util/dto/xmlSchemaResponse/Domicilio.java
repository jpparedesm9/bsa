package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

public class Domicilio {
    private String direccionUno;
    private String direccionDos;
    private String coloniaPoblacion;
    private String delegacionMunicipio;
    private String ciudad;
    private String estado;
    private String codigoPostal;
    private String numeroTelefono;
    private String tipoDomicilio;
    private String indicadorEspecialDomicilio;
    private String codPais;
    private String fechaReporteDireccion;

    public String getDireccionUno() {
        return direccionUno;
    }

    @XmlElement(name = "Direccion1")
    public void setDireccionUno(String direccionUno) {
        this.direccionUno = direccionUno;
    }

    public String getDireccionDos() {
        return direccionDos;
    }

    @XmlElement(name = "Direccion2")
    public void setDireccionDos(String direccionDos) {
        this.direccionDos = direccionDos;
    }

    public String getColoniaPoblacion() {
        return coloniaPoblacion;
    }

    @XmlElement(name = "ColoniaPoblacion")
    public void setColoniaPoblacion(String coloniaPoblacion) {
        this.coloniaPoblacion = coloniaPoblacion;
    }

    public String getDelegacionMunicipio() {
        return delegacionMunicipio;
    }

    @XmlElement(name = "DelegacionMunicipio")
    public void setDelegacionMunicipio(String delegacionMunicipio) {
        this.delegacionMunicipio = delegacionMunicipio;
    }

    public String getCiudad() {
        return ciudad;
    }

    @XmlElement(name = "Ciudad")
    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    @XmlElement(name = "Estado")
    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    @XmlElement(name = "CP")
    public void setCodigoPostal(String codigoPostal) {
        this.codigoPostal = codigoPostal;
    }

    public String getNumeroTelefono() {
        return numeroTelefono;
    }

    @XmlElement(name = "NumeroTelefono")
    public void setNumeroTelefono(String numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }

    public String getTipoDomicilio() {
        return tipoDomicilio;
    }

    @XmlElement(name = "TipoDomicilio")
    public void setTipoDomicilio(String tipoDomicilio) {
        this.tipoDomicilio = tipoDomicilio;
    }

    public String getIndicadorEspecialDomicilio() {
        return indicadorEspecialDomicilio;
    }

    @XmlElement(name = "IndicadorEspecialDomicilio")
    public void setIndicadorEspecialDomicilio(String indicadorEspecialDomicilio) {
        this.indicadorEspecialDomicilio = indicadorEspecialDomicilio;
    }

    public String getCodPais() {
        return codPais;
    }

    @XmlElement(name = "codPais")
    public void setCodPais(String codPais) {
        this.codPais = codPais;
    }

    public String getFechaReporteDireccion() {
        return fechaReporteDireccion;
    }

    @XmlElement(name = "FechaReporteDireccion")
    public void setFechaReporteDireccion(String fechaReporteDireccion) {
        this.fechaReporteDireccion = fechaReporteDireccion;
    }

    @Override
    public String toString() {
        return "Domicilio{" +
                "direccionUno='" + direccionUno + '\'' +
                ", direccionDos='" + direccionDos + '\'' +
                ", coloniaPoblacion='" + coloniaPoblacion + '\'' +
                ", delegacionMunicipio='" + delegacionMunicipio + '\'' +
                ", ciudad='" + ciudad + '\'' +
                ", estado='" + estado + '\'' +
                ", codigoPostal='" + codigoPostal + '\'' +
                ", numeroTelefono='" + numeroTelefono + '\'' +
                ", tipoDomicilio='" + tipoDomicilio + '\'' +
                ", indicadorEspecialDomicilio='" + indicadorEspecialDomicilio + '\'' +
                ", codPais='" + codPais + '\'' +
                ", fechaReporteDireccion='" + fechaReporteDireccion + '\'' +
                '}';
    }
}
