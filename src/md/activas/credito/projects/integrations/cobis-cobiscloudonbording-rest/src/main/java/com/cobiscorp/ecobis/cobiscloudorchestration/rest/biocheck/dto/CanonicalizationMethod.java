package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CanonicalizationMethod {
	 private String algorithm;


	 // Getter Methods 

	 public String getAlgorithm() {
	  return algorithm;
	 }

	 // Setter Methods 

	 public void setAlgorithm(String algorithm) {
	  this.algorithm = algorithm;
	 }
	}