package com.cobiscorp.cloud.notificationservice.model;

public class ResponseRule {

	private String estadoGENXML;
	private String timbrarXML;
	private String generarPdf;
	private String enviarEmail;
	private String tipoOperacion;

	public ResponseRule() {
		super();
	}

	public ResponseRule(String estadoGENXML, String timbrarXML, String generarPdf, String enviarEmail, String tipoOperacion) {
		
		super();
		this.estadoGENXML = estadoGENXML;
		this.timbrarXML = timbrarXML;
		this.generarPdf = generarPdf;
		this.enviarEmail = enviarEmail;
		this.tipoOperacion = tipoOperacion;
	}

	public String getEstadoGENXML() {
		return estadoGENXML;
	}

	public void setEstadoGENXML(String estadoGENXML) {
		this.estadoGENXML = estadoGENXML;
	}

	public String getTimbrarXML() {
		return timbrarXML;
	}

	public void setTimbrarXML(String timbrarXML) {
		this.timbrarXML = timbrarXML;
	}

	public String getGenerarPdf() {
		return generarPdf;
	}

	public void setGenerarPdf(String generarPdf) {
		this.generarPdf = generarPdf;
	}

	public String getEnviarEmail() {
		return enviarEmail;
	}

	public void setEnviarEmail(String enviarEmail) {
		this.enviarEmail = enviarEmail;
	}

	public String getTipoOperacion() {
		return tipoOperacion;
	}

	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}

}
