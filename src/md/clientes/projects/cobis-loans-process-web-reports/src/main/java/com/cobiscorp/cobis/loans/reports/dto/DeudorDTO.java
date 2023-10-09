package com.cobiscorp.cobis.loans.reports.dto;

public class DeudorDTO {

	private int clienteCodigo;
	private String clienteNombre;
	private String clienteDireccion;
	private String clienteRol;

	public int getClienteCodigo() {
		return clienteCodigo;
	}

	public void setClienteCodigo(int clienteCodigo) {
		this.clienteCodigo = clienteCodigo;
	}

	public String getClienteNombre() {
		return clienteNombre;
	}

	public void setClienteNombre(String clienteNombre) {
		this.clienteNombre = clienteNombre;
	}

	public String getClienteDireccion() {
		return clienteDireccion;
	}

	public void setClienteDireccion(String clienteDireccion) {
		this.clienteDireccion = clienteDireccion;
	}

	public String getClienteRol() {
		return clienteRol;
	}

	public void setClienteRol(String clienteRol) {
		this.clienteRol = clienteRol;
	}

}