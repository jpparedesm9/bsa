package com.cobiscorp.mobile.model.fingerid;

public class DataResponse {
    private RespuestaSituacionRegistral respuestaSituacionRegistral;
    private RespuestaComparacion respuestaComparacion;
    private Integer codigoRespuestaDatos;

    public RespuestaSituacionRegistral getRespuestaSituacionRegistral() {
        return respuestaSituacionRegistral;
    }
    public void setRespuestaSituacionRegistral(RespuestaSituacionRegistral respuestaSituacionRegistral) {
        this.respuestaSituacionRegistral = respuestaSituacionRegistral;
    }

    public RespuestaComparacion getRespuestaComparacion() {
        return respuestaComparacion;
    }
    public void setRespuestaComparacion(RespuestaComparacion respuestaComparacion) {
        this.respuestaComparacion = respuestaComparacion;
    }
	public Integer getCodigoRespuestaDatos() {
		return codigoRespuestaDatos;
	}
	public void setCodigoRespuestaDatos(Integer codigoRespuestaDatos) {
		this.codigoRespuestaDatos = codigoRespuestaDatos;
	}

    

}
