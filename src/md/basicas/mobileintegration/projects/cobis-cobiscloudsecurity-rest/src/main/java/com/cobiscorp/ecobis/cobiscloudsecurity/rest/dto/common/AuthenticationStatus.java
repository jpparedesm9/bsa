package com.cobiscorp.ecobis.cobiscloudsecurity.rest.dto.common;

import javax.ws.rs.core.Response;

public enum AuthenticationStatus {

	CREDENCIALES_INVALIDAS(5000, "Credenciales inválidas", null, Response.Status.UNAUTHORIZED, false),
	USUARIO_USADO_EN_OTRO_DISPOSITIVO(5005, "Usuario está siendo usado en otro dispositivo", "fue registrado anteriormente en", Response.Status.UNAUTHORIZED, false),
	PASSWORD_CADUCADO(5006, "Password caducado", "tiene password caducado", Response.Status.UNAUTHORIZED, false),
	USUARIO_BLOQUEADO(5007, "Usuario Bloqueado", "Usuario esta bloqueado", Response.Status.UNAUTHORIZED, false),
	DISPOSITIVO_BLOQUEADO(5010, "Dispositivo bloqueado", null, Response.Status.UNAUTHORIZED, false),
	DISPOSITIVO_BLOQUEADO_LIMPIAR_DATA(5001, "Dispositivo bloqueado", null, Response.Status.UNAUTHORIZED, false),
	DISPOSITIVO_NO_REGISTRADO(5008, "Dispositivo no registrado", null, Response.Status.UNAUTHORIZED, false),
	PROBLEMAS_AL_OBTENER_REGISTRO(5009, "Problemas al obtener registro de dispositivo", null, Response.Status.UNAUTHORIZED, false)

	;

	private int errorCode;
	private String message;
	private String search;
	private Response.Status status;
	private boolean authenticationResult;

	AuthenticationStatus(int errorCode, String message, String search, Response.Status status, boolean authenticationResult) {
		this.errorCode = errorCode;
		this.message = message;
		this.search = search;
		this.status = status;
		this.authenticationResult = authenticationResult;
	}

	public int getErrorCode() {
		return errorCode;
	}

	public String getMessage() {
		return message;
	}

	public String getSearch() {
		return search;
	}

	public Response.Status getStatus() {
		return status;
	}

	public boolean isAuthenticationResult() {
		return authenticationResult;
	}

}
