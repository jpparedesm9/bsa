package com.cobiscorp.cloud.notificationservice.dto.report;

public class ContratoCreditoInclusionDetalleDosDatosOpDTO {

	private String nombre;
	private String monto;
	private String montoDestAdeudo;
	private String montoDestCap;
	private String montoRecibir;

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getMonto() {
		return monto;
	}

	public void setMonto(String monto) {
		this.monto = monto;
	}

	public String getMontoDestAdeudo() {
		return montoDestAdeudo;
	}

	public void setMontoDestAdeudo(String montoDestAdeudo) {
		this.montoDestAdeudo = montoDestAdeudo;
	}

	public String getMontoDestCap() {
		return montoDestCap;
	}

	public void setMontoDestCap(String montoDestCap) {
		this.montoDestCap = montoDestCap;
	}

	public String getMontoRecibir() {
		return montoRecibir;
	}

	public void setMontoRecibir(String montoRecibir) {
		this.montoRecibir = montoRecibir;
	}

	
}