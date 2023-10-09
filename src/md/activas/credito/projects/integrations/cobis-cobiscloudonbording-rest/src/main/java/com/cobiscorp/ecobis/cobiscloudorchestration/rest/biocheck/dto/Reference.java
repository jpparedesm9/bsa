package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Reference {
	 DigestMethod DigestMethodObject;
	 private String digestValue;
	 private String uri;


	 // Getter Methods 

	 public DigestMethod getDigestMethod() {
	  return DigestMethodObject;
	 }

	 public String getDigestValue() {
	  return digestValue;
	 }

	 public String getUri() {
	  return uri;
	 }

	 // Setter Methods 

	 public void setDigestMethod(DigestMethod digestMethodObject) {
	  this.DigestMethodObject = digestMethodObject;
	 }

	 public void setDigestValue(String digestValue) {
	  this.digestValue = digestValue;
	 }

	 public void setUri(String uri) {
	  this.uri = uri;
	 }
	}