package com.cobiscorp.cloud.notificationservice.dto.report;

public class TablaAmortizacionDetalleDTO {

	private int dividend;
	private String expirationDate;
	private double ordinarInterest;
	private double interestIVA;
	private double abonoPrincipal;
	private double saldoInsoCap;
	private double montoPago;

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

	public double getInterestIVA() {
		return interestIVA;
	}

	public void setInterestIVA(double interestIVA) {
		this.interestIVA = interestIVA;
	}

	public double getAbonoPrincipal() {
		return abonoPrincipal;
	}

	public void setAbonoPrincipal(double abonoPrincipal) {
		this.abonoPrincipal = abonoPrincipal;
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

}
