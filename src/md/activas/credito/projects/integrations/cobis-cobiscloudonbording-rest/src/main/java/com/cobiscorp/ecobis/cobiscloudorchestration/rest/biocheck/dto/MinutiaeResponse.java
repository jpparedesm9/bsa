package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MinutiaeResponse {
	 private float codigoRespuestaMinucia;
	 private String similitud2;
	 private String similitud7;


	 // Getter Methods 

	 public float getCodigoRespuestaMinucia() {
	  return codigoRespuestaMinucia;
	 }

	 public String getSimilitud2() {
	  return similitud2;
	 }

	 public String getSimilitud7() {
	  return similitud7;
	 }

	 // Setter Methods 

	 public void setCodigoRespuestaMinucia(float codigoRespuestaMinucia) {
	  this.codigoRespuestaMinucia = codigoRespuestaMinucia;
	 }

	 public void setSimilitud2(String similitud2) {
	  this.similitud2 = similitud2;
	 }

	 public void setSimilitud7(String similitud7) {
	  this.similitud7 = similitud7;
	 }
	}