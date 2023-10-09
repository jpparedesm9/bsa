package com.cobis.cloud.sofom.service.oxxo.dto;

public class OlsConsultaRequest {
	
	private String token;
	private String referencia;
	
	
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
	
	
	@Override
	public String toString() {
		return "OlsConsultaRequest [token=" + token + ", referencia="
				+ referencia + "]";
	}
	
}
