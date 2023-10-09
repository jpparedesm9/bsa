package com.cobiscorp.mobile.model;

public class ElavonRequest extends BaseRequest {

	private String loanId;
	private String reference;
	private double amount;
	private double minimumPayment;
	private double maximumPayment;
	private String moneda;
	private String fechaVigencia;
	private String email;

	public String getLoanId() {
		return loanId;
	}

	public void setLoanId(String loanId) {
		this.loanId = loanId;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getMinimumPayment() {
		return minimumPayment;
	}

	public void setMinimumPayment(double minimumPayment) {
		this.minimumPayment = minimumPayment;
	}

	public double getMaximumPayment() {
		return maximumPayment;
	}

	public void setMaximumPayment(double maximumPayment) {
		this.maximumPayment = maximumPayment;
	}

	public String getMoneda() {
		return moneda;
	}

	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}

	public String getFechaVigencia() {
		return fechaVigencia;
	}

	public void setFechaVigencia(String fechaVigencia) {
		this.fechaVigencia = fechaVigencia;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "ElavonRequest [loanId=" + loanId + ", reference=" + reference + ", amount=" + amount + ", minimumPayment=" + minimumPayment + ", maximumPayment=" + maximumPayment
				+ ", moneda=" + moneda + ", fechaVigencia=" + fechaVigencia + ", email=" + email + "]";
	}

}
