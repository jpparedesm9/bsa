package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class KeyInfo {
	@JsonProperty("x509Data")
	DataInfo x509Data;

	public DataInfo getX509Data() {
		return x509Data;
	}

	public void setX509Data(DataInfo x509Data) {
		this.x509Data = x509Data;
	}

	
}
