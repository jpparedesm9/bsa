package com.cobiscorp.cobis.assets.reports.dto;

public class Pago {

	public Pago(String institucion, String referencia, String convenio) {
		this.institucion = institucion;
		this.referencia = referencia;
		this.convenio = convenio;

	}

	private String institucion;
	private String referencia;
	private String convenio;

	public String getInstitucion() {
		return institucion;
	}

	public void setInstitucion(String institucion) {
		this.institucion = institucion;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}

	public String getConvenio() {
		return convenio;
	}

	public void setConvenio(String convenio) {
		this.convenio = convenio;
	}

}
