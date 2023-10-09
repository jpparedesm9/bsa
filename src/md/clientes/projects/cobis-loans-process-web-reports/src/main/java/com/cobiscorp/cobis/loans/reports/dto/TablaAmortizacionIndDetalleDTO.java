package com.cobiscorp.cobis.loans.reports.dto;


public class TablaAmortizacionIndDetalleDTO {

	private int dividend;
	private String expirationDate;
	private double balance;
	private double capital;
	private double criminalInterest;
	private double others;
	private double share;
	private double ordinarInterest;
	private double interestIVA;

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

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	public double getCapital() {
		return capital;
	}

	public void setCapital(double capital) {
		this.capital = capital;
	}

	public double getCriminalInterest() {
		return criminalInterest;
	}

	public void setCriminalInterest(double criminalInterest) {
		this.criminalInterest = criminalInterest;
	}

	public double getShare() {
		return share;
	}

	public void setShare(double share) {
		this.share = share;
	}

	public double getOthers() {
		return others;
	}

	public void setOthers(double others) {
		this.others = others;
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
	
}
