package com.cobiscorp.cloud.notificationservice.model;

public class ConectorTimbrado {

	private String nombreConector;
	private String rutaEntrada;
	private String rutaIngreso;
	private String estado;

	public ConectorTimbrado() {

	}

	public ConectorTimbrado(String nombreConector, String rutaEntrada, String rutaIngreso, String estado) {
		this.nombreConector = nombreConector;
		this.rutaEntrada = rutaEntrada;
		this.rutaIngreso = rutaIngreso;
		this.estado = estado;
	}

	public String getNombreConector() {
		return nombreConector;
	}

	public void setNombreConector(String nombreConector) {
		this.nombreConector = nombreConector;
	}

	public String getRutaEntrada() {
		return rutaEntrada;
	}

	public void setRutaEntrada(String rutaEntrada) {
		this.rutaEntrada = rutaEntrada;
	}

	public String getRutaIngreso() {
		return rutaIngreso;
	}

	public void setRutaIngreso(String rutaIngreso) {
		this.rutaIngreso = rutaIngreso;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ConectorTimbrado [nombreConector=");
		builder.append(nombreConector);
		builder.append(", rutaEntrada=");
		builder.append(rutaEntrada);
		builder.append(", rutaIngreso=");
		builder.append(rutaIngreso);
		builder.append(", estado=");
		builder.append(estado);
		builder.append("]");
		return builder.toString();
	}

}
