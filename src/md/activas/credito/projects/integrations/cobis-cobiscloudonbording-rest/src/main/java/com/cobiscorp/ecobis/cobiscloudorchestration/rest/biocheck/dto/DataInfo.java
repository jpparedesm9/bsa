package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class DataInfo {
	@JsonProperty("x509SerialNumber")
	String x509SerialNumber;

	public String getX509SerialNumber() {
		return x509SerialNumber;
	}

	public void setX509SerialNumber(String x509SerialNumber) {
		this.x509SerialNumber = x509SerialNumber;
	}
	
	
}
