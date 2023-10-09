package com.cobiscorp.cobis.loans.reports.dto;

public class HojaLiquidacionDTO {

	// Resumen Credito
	private int numero;
	private String numPrestamo;
	private String nombreCliente;
	private Double montoAprobado;
	private Double valoresDescontar;
	private Double ahorro;
	private Double incentivo;
	private Double netoEntregar;
	private String cheque;

	public int getNumero() {
		return numero;
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}

	public String getNumPrestamo() {
		return numPrestamo;
	}

	public void setNumPrestamo(String numPrestamo) {
		this.numPrestamo = numPrestamo;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public Double getMontoAprobado() {
		return montoAprobado;
	}

	public void setMontoAprobado(Double montoAprobado) {
		this.montoAprobado = montoAprobado;
	}

	public Double getValoresDescontar() {
		return valoresDescontar;
	}

	public void setValoresDescontar(Double valoresDescontar) {
		this.valoresDescontar = valoresDescontar;
	}

	public Double getAhorro() {
		return ahorro;
	}

	public void setAhorro(Double ahorro) {
		this.ahorro = ahorro;
	}

	public Double getIncentivo() {
		return incentivo;
	}

	public void setIncentivo(Double incentivo) {
		this.incentivo = incentivo;
	}

	public Double getNetoEntregar() {
		return netoEntregar;
	}

	public void setNetoEntregar(Double netoEntregar) {
		this.netoEntregar = netoEntregar;
	}

	public String getCheque() {
		return cheque;
	}

	public void setCheque(String cheque) {
		this.cheque = cheque;
	}

}