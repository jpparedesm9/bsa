package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class RespuestaComparacion {
	private boolean anioRegistro;
	private boolean claveElector;
	private boolean apellidoPaterno;
	private boolean anioEmision;
	private boolean numeroEmisionCredencial;
	private boolean nombre;
	private boolean curp;
	private boolean apellidoMaterno;
	private boolean ocr;

	// Getter Methods

	public boolean getAnioRegistro() {
		return anioRegistro;
	}

	public boolean getClaveElector() {
		return claveElector;
	}

	public boolean getApellidoPaterno() {
		return apellidoPaterno;
	}

	public boolean getAnioEmision() {
		return anioEmision;
	}

	public boolean getNumeroEmisionCredencial() {
		return numeroEmisionCredencial;
	}

	public boolean getNombre() {
		return nombre;
	}

	public boolean getCurp() {
		return curp;
	}

	public boolean getApellidoMaterno() {
		return apellidoMaterno;
	}

	public boolean getOcr() {
		return ocr;
	}

	// Setter Methods

	public void setAnioRegistro(boolean anioRegistro) {
		this.anioRegistro = anioRegistro;
	}

	public void setClaveElector(boolean claveElector) {
		this.claveElector = claveElector;
	}

	public void setApellidoPaterno(boolean apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}

	public void setAnioEmision(boolean anioEmision) {
		this.anioEmision = anioEmision;
	}

	public void setNumeroEmisionCredencial(boolean numeroEmisionCredencial) {
		this.numeroEmisionCredencial = numeroEmisionCredencial;
	}

	public void setNombre(boolean nombre) {
		this.nombre = nombre;
	}

	public void setCurp(boolean curp) {
		this.curp = curp;
	}

	public void setApellidoMaterno(boolean apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}

	public void setOcr(boolean ocr) {
		this.ocr = ocr;
	}
}