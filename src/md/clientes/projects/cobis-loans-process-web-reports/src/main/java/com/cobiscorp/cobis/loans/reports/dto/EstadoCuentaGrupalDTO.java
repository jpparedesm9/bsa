package com.cobiscorp.cobis.loans.reports.dto;

public class EstadoCuentaGrupalDTO {

	// Resumen Credito
	private String concepto;
	private Double saldoInicial;
	private Double abonos;
	private Double saldoActual;
	private Double vencido;

	// Plan Pagos
	private int pago;
	private String fecha;
	private Double capital;
	private Double interes;
	private Double otros;
	private Double saldo;
	private Double voluntario;
	private Double extra;
	private Double cuota;

	public String getConcepto() {
		return concepto;
	}

	public void setConcepto(String concepto) {
		this.concepto = concepto;
	}

	public Double getSaldoInicial() {
		return saldoInicial;
	}

	public void setSaldoInicial(Double saldoInicial) {
		this.saldoInicial = saldoInicial;
	}

	public Double getAbonos() {
		return abonos;
	}

	public void setAbonos(Double abonos) {
		this.abonos = abonos;
	}

	public Double getSaldoActual() {
		return saldoActual;
	}

	public void setSaldoActual(Double saldoActual) {
		this.saldoActual = saldoActual;
	}

	public Double getVencido() {
		return vencido;
	}

	public void setVencido(Double vencido) {
		this.vencido = vencido;
	}

	public int getPago() {
		return pago;
	}

	public void setPago(int pago) {
		this.pago = pago;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public Double getCapital() {
		return capital;
	}

	public void setCapital(Double capital) {
		this.capital = capital;
	}

	public Double getInteres() {
		return interes;
	}

	public void setInteres(Double interes) {
		this.interes = interes;
	}

	public Double getOtros() {
		return otros;
	}

	public void setOtros(Double otros) {
		this.otros = otros;
	}

	public Double getSaldo() {
		return saldo;
	}

	public void setSaldo(Double saldo) {
		this.saldo = saldo;
	}

	public Double getVoluntario() {
		return voluntario;
	}

	public void setVoluntario(Double voluntario) {
		this.voluntario = voluntario;
	}

	public Double getExtra() {
		return extra;
	}

	public void setExtra(Double extra) {
		this.extra = extra;
	}

	public Double getCuota() {
		return cuota;
	}

	public void setCuota(Double cuota) {
		this.cuota = cuota;
	}

}