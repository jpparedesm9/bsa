package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

public class BiocheckRuleResponse {
	
	public BiocheckRuleResponse(String response) {
		this.response = response;
	}
	
	private String response;

	public String getResponse() {
		return response;
	}

	public void setResponse(String response) {
		this.response = response;
	}
	

}
