package com.cobiscorp.ecobis.cobiscloudburo.util.dto;

import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Respuesta;

import java.util.Map;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class BuroResponse {
    private Map<String, Object> data;
    private String responseXml;
    private Respuesta respuesta;

    public BuroResponse() {

    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public String getResponseXml() {
        return responseXml;
    }

    public void setResponseXml(String responseXml) {
        this.responseXml = responseXml;
    }

    public Respuesta getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(Respuesta respuesta) {
        this.respuesta = respuesta;
    }
}
