package com.cobiscorp.mobile.model;

public class SimulationResponse {

	private double amountPay;

	public double getAmountPay() {
		return amountPay;
	}

	public void setAmountPay(double amountPay) {
		this.amountPay = amountPay;
	}

	@Override
	public String toString() {
		return "SimulationResponse [amountPay=" + amountPay + "]";
	}

}
