package com.cobiscorp.cobis.loans.reports.dto;

public class TablaSimulacionDetalleDTO {

	private int dividend;
	private String expirationDate;
	private double ordinarInterest;
	private double saldoInsoCap;
	private double montoPago;
	private double ivaInterest;
	private double creditCapital;

	public int getDividend() {
		return dividend;
	}

	public void setDividend(int dividend) {
		this.dividend = dividend;
	}

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}

	public double getOrdinarInterest() {
		return ordinarInterest;
	}

	public void setOrdinarInterest(double ordinarInterest) {
		this.ordinarInterest = ordinarInterest;
	}

	public double getSaldoInsoCap() {
		return saldoInsoCap;
	}

	public void setSaldoInsoCap(double saldoInsoCap) {
		this.saldoInsoCap = saldoInsoCap;
	}

	public double getMontoPago() {
		return montoPago;
	}

	public void setMontoPago(double montoPago) {
		this.montoPago = montoPago;
	}

	public double getIvaInterest() {
		return ivaInterest;
	}

	public void setIvaInterest(double ivaInterest) {
		this.ivaInterest = ivaInterest;
	}

	public double getCreditCapital() {
		return creditCapital;
	}

	public void setCreditCapital(double creditCapital) {
		this.creditCapital = creditCapital;
	}

}
