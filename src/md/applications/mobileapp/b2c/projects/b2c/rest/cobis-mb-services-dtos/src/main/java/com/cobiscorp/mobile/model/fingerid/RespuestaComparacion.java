package com.cobiscorp.mobile.model.fingerid;

public class RespuestaComparacion {
    private Boolean anioRegistro;
    private Boolean claveElector;
    private Boolean apellidoPaterno;
    private Boolean anioEmision;
    private Boolean numeroEmisionCredencial;
    private Boolean nombre;
    private Boolean curp;
    private Boolean apellidoMaterno;
    private Boolean ocr;

    public Boolean getAnioRegistro() {
		return anioRegistro;
	}
	public void setAnioRegistro(Boolean anioRegistro) {
		this.anioRegistro = anioRegistro;
	}
	public Boolean getClaveElector() {
        return claveElector;
    }
    public void setClaveElector(Boolean claveElector) {
        this.claveElector = claveElector;
    }

    public Boolean getApellidoPaterno() {
        return apellidoPaterno;
    }
    public void setApellidoPaterno(Boolean apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }

    public Boolean getAnioEmision() {
        return anioEmision;
    }
    public void setAnioEmision(Boolean anioEmision) {
        this.anioEmision = anioEmision;
    }

    public Boolean getNumeroEmisionCredencial() {
        return numeroEmisionCredencial;
    }
    public void setNumeroEmisionCredencial(Boolean numeroEmisionCredencial) {
        this.numeroEmisionCredencial = numeroEmisionCredencial;
    }

    public Boolean getNombre() {
        return nombre;
    }
    public void setNombre(Boolean nombre) {
        this.nombre = nombre;
    }

    public Boolean getCurp() {
        return curp;
    }
    public void setCurp(Boolean curp) {
        this.curp = curp;
    }

    public Boolean getApellidoMaterno() {
        return apellidoMaterno;
    }
    public void setApellidoMaterno(Boolean apellidoMaterno) {
        this.apellidoMaterno = apellidoMaterno;
    }

    public Boolean getOcr() {
        return ocr;
    }
    public void setOcr(Boolean ocr) {
        this.ocr = ocr;
    }
}
