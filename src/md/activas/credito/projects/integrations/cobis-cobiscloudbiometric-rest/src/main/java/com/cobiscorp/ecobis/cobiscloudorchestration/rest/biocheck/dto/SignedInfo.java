package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class SignedInfo {
	 CanonicalizationMethod CanonicalizationMethodObject;
	 SignatureMethod SignatureMethodObject;
	 Reference ReferenceObject;


	 // Getter Methods 

	 public CanonicalizationMethod getCanonicalizationMethod() {
	  return CanonicalizationMethodObject;
	 }

	 public SignatureMethod getSignatureMethod() {
	  return SignatureMethodObject;
	 }

	 public Reference getReference() {
	  return ReferenceObject;
	 }

	 // Setter Methods 

	 public void setCanonicalizationMethod(CanonicalizationMethod canonicalizationMethodObject) {
	  this.CanonicalizationMethodObject = canonicalizationMethodObject;
	 }

	 public void setSignatureMethod(SignatureMethod signatureMethodObject) {
	  this.SignatureMethodObject = signatureMethodObject;
	 }

	 public void setReference(Reference referenceObject) {
	  this.ReferenceObject = referenceObject;
	 }
	}