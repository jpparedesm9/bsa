package com.cobiscorp.mobile.model.fingerid;

public class Response {
    private String fechaHoraPeticion;
    private String indiceSolicitud;
    private DataResponse dataResponse;
    private MinutiaeResponse minutiaeResponse;
    private Integer tiempoProcesamiento;
    private Integer codigoRespuesta;

    public String getFechaHoraPeticion() {
        return fechaHoraPeticion;
    }
    public void setFechaHoraPeticion(String fechaHoraPeticion) {
        this.fechaHoraPeticion = fechaHoraPeticion;
    }

    public String getIndiceSolicitud() {
        return indiceSolicitud;
    }
    public void setIndiceSolicitud(String indiceSolicitud) {
        this.indiceSolicitud = indiceSolicitud;
    }

    public DataResponse getDataResponse() {
        return dataResponse;
    }
    public void setDataResponse(DataResponse dataResponse) {
        this.dataResponse = dataResponse;
    }

    public MinutiaeResponse getMinutiaeResponse() {
        return minutiaeResponse;
    }
    public void setMinutiaeResponse(MinutiaeResponse minutiaeResponse) {
        this.minutiaeResponse = minutiaeResponse;
    }

    public Integer getTiempoProcesamiento() {
        return tiempoProcesamiento;
    }
    public void setTiempoProcesamiento(Integer tiempoProcesamiento) {
        this.tiempoProcesamiento = tiempoProcesamiento;
    }

    public Integer getCodigoRespuesta() {
        return codigoRespuesta;
    }
    public void setCodigoRespuesta(Integer codigoRespuesta) {
        this.codigoRespuesta = codigoRespuesta;
    }

}
