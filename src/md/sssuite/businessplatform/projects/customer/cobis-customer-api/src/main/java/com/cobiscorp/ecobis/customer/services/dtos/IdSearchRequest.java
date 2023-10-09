package com.cobiscorp.ecobis.customer.services.dtos;

public class IdSearchRequest {

	public IdSearchRequest() {		
		
	}
	private String identification;

	public String getIdentification() {
		return identification;
	}
	public IdSearchRequest(String identification) {
		super();
		this.identification = identification;
	}
	
	public void setIdentification(String identification) {
		this.identification = identification;
	}
}
