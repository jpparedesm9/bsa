package com.cobiscorp.ecobis.cloud.service.dto.prospect;

public class ProspectCreateResponse {

	private int ente;
	private int direccion;
	private int telefono;
	private String li_negra;
	private String neg_file;
	private String enrol_estatus;
	private String rfc;
	private String nomlar;

	public int getEnte() {
		return ente;
	}

	public void setEnte(int ente) {
		this.ente = ente;
	}

	public int getDireccion() {
		return direccion;
	}

	public void setDireccion(int direccion) {
		this.direccion = direccion;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	public String getLi_negra() {
		return li_negra;
	}

	public void setLi_negra(String li_negra) {
		this.li_negra = li_negra;
	}

	public String getNeg_file() {
		return neg_file;
	}

	public void setNeg_file(String neg_file) {
		this.neg_file = neg_file;
	}

	public String getEnrol_estatus() {
		return enrol_estatus;
	}

	public void setEnrol_estatus(String enrol_estatus) {
		this.enrol_estatus = enrol_estatus;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public String getNomlar() {
		return nomlar;
	}

	public void setNomlar(String nomlar) {
		this.nomlar = nomlar;
	}
}
