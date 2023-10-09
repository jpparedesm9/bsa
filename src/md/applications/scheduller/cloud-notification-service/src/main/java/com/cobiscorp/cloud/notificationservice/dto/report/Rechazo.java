package com.cobiscorp.cloud.notificationservice.dto.report;

public class Rechazo {

	Integer tramite;
	String fecha;
	Integer cliente;
	String Nombre;
	String apellidoPaterno;
	String apellidoMaterno;
	String observaciones;

	public Rechazo(Integer tramite, String fecha, Integer cliente, String nombre, String apellidoPaterno, String apellidoMaterno, String observaciones) {
		super();
		this.tramite = tramite;
		this.fecha = fecha;
		this.cliente = cliente;
		Nombre = nombre;
		this.apellidoPaterno = apellidoPaterno;
		this.apellidoMaterno = apellidoMaterno;
		this.observaciones = observaciones;
	}

	public Integer getTramite() {
		return tramite;
	}

	public void setTramite(Integer tramite) {
		this.tramite = tramite;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public Integer getCliente() {
		return cliente;
	}

	public void setCliente(Integer cliente) {
		this.cliente = cliente;
	}

	public String getNombre() {
		return Nombre;
	}

	public void setNombre(String nombre) {
		Nombre = nombre;
	}

	public String getApellidoPaterno() {
		return apellidoPaterno;
	}

	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}

	public String getApellidoMaterno() {
		return apellidoMaterno;
	}

	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
}
