package com.cobiscorp.cloud.notificationservice.dto.report;

public class AlertaReport {

	public AlertaReport(String cliente, String nombre, String tipolista) {
		this.cliente = cliente;
		this.nombre = nombre;
		this.tipolista = tipolista;
	}

	public String cliente;
	public String nombre;
	public String tipolista;

	public String getCliente() {
		return cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTipolista() {
		return tipolista;
	}

	public void setTipolista(String tipolista) {
		this.tipolista = tipolista;
	}
}
