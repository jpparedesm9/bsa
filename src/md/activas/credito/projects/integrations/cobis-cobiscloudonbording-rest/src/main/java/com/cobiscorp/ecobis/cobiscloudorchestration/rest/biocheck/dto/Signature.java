package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Signature {
	 SignedInfo signedInfoObject;
	 String signatureValue;
	 KeyInfo keyInfo;


	 // Getter Methods 

	 public SignedInfo getSignedInfo() {
	  return signedInfoObject;
	 }

	 // Setter Methods 

	 public void setSignedInfo(SignedInfo signedInfoObject) {
	  this.signedInfoObject = signedInfoObject;
	 }

	public String getSignatureValue() {
		return signatureValue;
	}

	public void setSignatureValue(String signatureValue) {
		this.signatureValue = signatureValue;
	}

	public KeyInfo getKeyInfo() {
		return keyInfo;
	}

	public void setKeyInfo(KeyInfo keyInfo) {
		this.keyInfo = keyInfo;
	}
	
	 
	}