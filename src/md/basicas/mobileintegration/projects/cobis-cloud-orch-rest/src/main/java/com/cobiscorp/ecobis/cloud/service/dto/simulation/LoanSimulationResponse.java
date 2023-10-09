package com.cobiscorp.ecobis.cloud.service.dto.simulation;

public class LoanSimulationResponse {

	private double amountPay;
	private double rate;
	private double currency;
		
	public double getAmountPay() {
		return amountPay;
	}

	public void setAmountPay(double amountPay) {
		this.amountPay = amountPay;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public double getCurrency() {
		return currency;
	}

	public void setCurrency(double currency) {
		this.currency = currency;
	}

	@Override
	public String toString() {
		return "LoanSimulationResponse [amountPay=" + amountPay + "]";
	}
}
