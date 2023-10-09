package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class DataResponse {
	 RespuestaSituacionRegistral respuestaSituacionRegistralObject;
	 RespuestaComparacion respuestaComparacionObject;
	 private float codigoRespuestaDatos;


	 // Getter Methods 

	 public RespuestaSituacionRegistral getRespuestaSituacionRegistral() {
	  return respuestaSituacionRegistralObject;
	 }

	 public RespuestaComparacion getRespuestaComparacion() {
	  return respuestaComparacionObject;
	 }

	 public float getCodigoRespuestaDatos() {
	  return codigoRespuestaDatos;
	 }

	 // Setter Methods 

	 public void setRespuestaSituacionRegistral(RespuestaSituacionRegistral respuestaSituacionRegistralObject) {
	  this.respuestaSituacionRegistralObject = respuestaSituacionRegistralObject;
	 }

	 public void setRespuestaComparacion(RespuestaComparacion respuestaComparacionObject) {
	  this.respuestaComparacionObject = respuestaComparacionObject;
	 }

	 public void setCodigoRespuestaDatos(float codigoRespuestaDatos) {
	  this.codigoRespuestaDatos = codigoRespuestaDatos;
	 }
	}