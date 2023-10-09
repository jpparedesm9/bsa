package com.cobiscorp.cloud.notificationservice.dto.report;

public class Notificacion {
	
	public Notificacion(String mensaje) {
		this.mensaje = mensaje;

	}

	public String mensaje;

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	
}
