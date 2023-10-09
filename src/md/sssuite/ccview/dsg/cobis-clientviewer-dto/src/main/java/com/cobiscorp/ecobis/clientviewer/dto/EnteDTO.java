package com.cobiscorp.ecobis.clientviewer.dto;

public class EnteDTO {

	private Integer ente;
	private String ccaRate;

	public EnteDTO(Integer ente, String ccaRate) {
		this.ente = ente;
		this.ccaRate = ccaRate;
	}

	public Integer getEnte() {
		return ente;
	}

	public void setEnte(Integer ente) {
		this.ente = ente;
	}

	public String getCcaRate() {
		return ccaRate;
	}

	public void setCcaRate(String ccaRate) {
		this.ccaRate = ccaRate;
	}

}
