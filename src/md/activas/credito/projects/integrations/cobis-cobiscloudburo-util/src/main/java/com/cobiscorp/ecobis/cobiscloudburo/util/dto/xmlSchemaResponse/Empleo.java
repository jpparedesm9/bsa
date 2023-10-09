package com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse;

import javax.xml.bind.annotation.XmlElement;

public class Empleo {
    private String nombreEmpresa;
    private String direccionUno;
    private String direccionDos;
    private String coloniaPoblacion;
    private String delegacionMunicipio;
    private String ciudad;
    private String estado;
    private String codigoPostal;
    private String numeroTelefono;
    private String extension;
    private String fax;
    private String cargo;
    private String fechaContratacion;
    private String claveMoneda;
    private String salario;
    private String baseSalarial;
    private String numeroEmpleado;
    private String fechaUltimoDiaEmpleo;
    private String fechaReportoEmpleo;
    private String fechaVerificacionEmpleo;
    private String modoVerificacion;
    private String codigoPais;

    public String getNombreEmpresa() {
        return nombreEmpresa;
    }

    @XmlElement(name = "NombreEmpresa")
    public void setNombreEmpresa(String nombreEmpresa) {
        this.nombreEmpresa = nombreEmpresa;
    }

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

    public String getExtension() {
        return extension;
    }

    @XmlElement(name = "Extension")
    public void setExtension(String extension) {
        this.extension = extension;
    }

    public String getFax() {
        return fax;
    }

    @XmlElement(name = "Fax")
    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getCargo() {
        return cargo;
    }

    @XmlElement(name = "Cargo")
    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public String getFechaContratacion() {
        return fechaContratacion;
    }

    @XmlElement(name = "FechaContratacion")
    public void setFechaContratacion(String fechaContratacion) {
        this.fechaContratacion = fechaContratacion;
    }

    public String getClaveMoneda() {
        return claveMoneda;
    }

    @XmlElement(name = "ClaveMoneda")
    public void setClaveMoneda(String claveMoneda) {
        this.claveMoneda = claveMoneda;
    }

    public String getSalario() {
        return salario;
    }

    @XmlElement(name = "Salario")
    public void setSalario(String salario) {
        this.salario = salario;
    }

    public String getBaseSalarial() {
        return baseSalarial;
    }

    @XmlElement(name = "BaseSalarial")
    public void setBaseSalarial(String baseSalarial) {
        this.baseSalarial = baseSalarial;
    }

    public String getNumeroEmpleado() {
        return numeroEmpleado;
    }

    @XmlElement(name = "NumeroEmpleado")
    public void setNumeroEmpleado(String numeroEmpleado) {
        this.numeroEmpleado = numeroEmpleado;
    }

    public String getFechaUltimoDiaEmpleo() {
        return fechaUltimoDiaEmpleo;
    }

    @XmlElement(name = "FechaUltimoDiaEmpleo")
    public void setFechaUltimoDiaEmpleo(String fechaUltimoDiaEmpleo) {
        this.fechaUltimoDiaEmpleo = fechaUltimoDiaEmpleo;
    }

    public String getFechaReportoEmpleo() {
        return fechaReportoEmpleo;
    }

    @XmlElement(name = "FechaReportoEmpleo")
    public void setFechaReportoEmpleo(String fechaReportoEmpleo) {
        this.fechaReportoEmpleo = fechaReportoEmpleo;
    }

    public String getFechaVerificacionEmpleo() {
        return fechaVerificacionEmpleo;
    }

    @XmlElement(name = "FechaVerificacionEmpleo")
    public void setFechaVerificacionEmpleo(String fechaVerificacionEmpleo) {
        this.fechaVerificacionEmpleo = fechaVerificacionEmpleo;
    }

    public String getModoVerificacion() {
        return modoVerificacion;
    }

    @XmlElement(name = "ModoVerificacion")
    public void setModoVerificacion(String modoVerificacion) {
        this.modoVerificacion = modoVerificacion;
    }

    public String getCodigoPais() {
        return codigoPais;
    }

    @XmlElement(name = "CodPais")
    public void setCodigoPais(String codigoPais) {
        this.codigoPais = codigoPais;
    }

    @Override
    public String toString() {
        return "Empleo{" +
                "nombreEmpresa='" + nombreEmpresa + '\'' +
                ", direccionUno='" + direccionUno + '\'' +
                ", direccionDos='" + direccionDos + '\'' +
                ", coloniaPoblacion='" + coloniaPoblacion + '\'' +
                ", delegacionMunicipio='" + delegacionMunicipio + '\'' +
                ", ciudad='" + ciudad + '\'' +
                ", estado='" + estado + '\'' +
                ", codigoPostal='" + codigoPostal + '\'' +
                ", numeroTelefono='" + numeroTelefono + '\'' +
                ", extension='" + extension + '\'' +
                ", fax='" + fax + '\'' +
                ", cargo='" + cargo + '\'' +
                ", fechaContratacion='" + fechaContratacion + '\'' +
                ", claveMoneda='" + claveMoneda + '\'' +
                ", salario='" + salario + '\'' +
                ", baseSalarial='" + baseSalarial + '\'' +
                ", numeroEmpleado='" + numeroEmpleado + '\'' +
                ", fechaUltimoDiaEmpleo='" + fechaUltimoDiaEmpleo + '\'' +
                ", fechaReportoEmpleo='" + fechaReportoEmpleo + '\'' +
                ", fechaVerificacionEmpleo='" + fechaVerificacionEmpleo + '\'' +
                ", modoVerificacion='" + modoVerificacion + '\'' +
                ", codigoPais='" + codigoPais + '\'' +
                '}';
    }
}
