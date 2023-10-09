package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Response {
	 private String fechaHoraPeticion;
	 private String indiceSolicitud;
	 DataResponse dataResponseObject;
	 MinutiaeResponse minutiaeResponseObject;
	 private float tiempoProcesamiento;
	 private float codigoRespuesta;


	 // Getter Methods 

	 public String getFechaHoraPeticion() {
	  return fechaHoraPeticion;
	 }

	 public String getIndiceSolicitud() {
	  return indiceSolicitud;
	 }

	 public DataResponse getDataResponse() {
	  return dataResponseObject;
	 }

	 public MinutiaeResponse getMinutiaeResponse() {
	  return minutiaeResponseObject;
	 }

	 public float getTiempoProcesamiento() {
	  return tiempoProcesamiento;
	 }

	 public float getCodigoRespuesta() {
	  return codigoRespuesta;
	 }

	 // Setter Methods 

	 public void setFechaHoraPeticion(String fechaHoraPeticion) {
	  this.fechaHoraPeticion = fechaHoraPeticion;
	 }

	 public void setIndiceSolicitud(String indiceSolicitud) {
	  this.indiceSolicitud = indiceSolicitud;
	 }

	 public void setDataResponse(DataResponse dataResponseObject) {
	  this.dataResponseObject = dataResponseObject;
	 }

	 public void setMinutiaeResponse(MinutiaeResponse minutiaeResponseObject) {
	  this.minutiaeResponseObject = minutiaeResponseObject;
	 }

	 public void setTiempoProcesamiento(float tiempoProcesamiento) {
	  this.tiempoProcesamiento = tiempoProcesamiento;
	 }

	 public void setCodigoRespuesta(float codigoRespuesta) {
	  this.codigoRespuesta = codigoRespuesta;
	 }
	}