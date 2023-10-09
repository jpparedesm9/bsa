package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "mensaje",
    "codigoMensaje",
    "token"
})
@JsonIgnoreProperties(ignoreUnknown = true)
public class StokenGeneratorResponse {
	private static final long serialVersionUID = 1L;
	@JsonProperty("mensaje")
	String mensaje;
	@JsonProperty("codigoMensaje")
	String codigoMensaje;
	@JsonProperty("token")
	String token;

	@JsonProperty("mensaje")
	public String getMensaje() {
		return mensaje;
	}
	@JsonProperty("mensaje")
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	@JsonProperty("codigoMensaje")
	public String getCodigoMensaje() {
		return codigoMensaje;
	}
	@JsonProperty("codigoMensaje")
	public void setCodigoMensaje(String codigoMensaje) {
		this.codigoMensaje = codigoMensaje;
	}
	@JsonProperty("token")
	public String getToken() {
		return token;
	}
	@JsonProperty("token")
	public void setToken(String token) {
		this.token = token;
	}
	
	
	@Override
	public String toString() {
		return "StokenGeneratorResponse [mensaje=" + mensaje + ", codigoMensaje=" + codigoMensaje + ", token=" + token + "]";
	}
	
}
