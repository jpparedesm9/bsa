package com.cobiscorp.ecobis.cloud.service.dto.security;

public class ValidationCodeResponse {

	private String value;
	private String fecha;
	
	
	public ValidationCodeResponse(){}

	public ValidationCodeResponse(String value, String fecha) {
		super();
		this.value=value;
		this.fecha=fecha;

	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}


	

}
