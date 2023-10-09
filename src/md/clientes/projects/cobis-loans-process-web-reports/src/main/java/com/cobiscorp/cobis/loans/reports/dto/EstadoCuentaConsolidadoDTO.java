package com.cobiscorp.cobis.loans.reports.dto;

public class EstadoCuentaConsolidadoDTO {
	private String fecha;
	private String cliente;
	private double otorgado;
	private double saldoCapital;
	private double ahorros;
	private double capital;
	private double intOtros;
	private double total;
	private int idCliente;
	private String numeroDocCli;

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getCliente() {
		return cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public double getOtorgado() {
		return otorgado;
	}

	public void setOtorgado(double otorgado) {
		this.otorgado = otorgado;
	}

	public double getSaldoCapital() {
		return saldoCapital;
	}

	public void setSaldoCapital(double saldoCapital) {
		this.saldoCapital = saldoCapital;
	}

	public double getAhorros() {
		return ahorros;
	}

	public void setAhorros(double ahorros) {
		this.ahorros = ahorros;
	}

	public double getCapital() {
		return capital;
	}

	public void setCapital(double capital) {
		this.capital = capital;
	}

	public double getIntOtros() {
		return intOtros;
	}

	public void setIntOtros(double intOtros) {
		this.intOtros = intOtros;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public String getNumeroDocCli() {
		return numeroDocCli;
	}

	public void setNumeroDocCli(String numeroDocCli) {
		this.numeroDocCli = numeroDocCli;
	}

}