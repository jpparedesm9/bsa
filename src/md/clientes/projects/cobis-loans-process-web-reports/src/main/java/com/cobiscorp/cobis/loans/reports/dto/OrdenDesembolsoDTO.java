package com.cobiscorp.cobis.loans.reports.dto;

public class OrdenDesembolsoDTO {

	private String officerNameDisbursement;
	private String disbursementrate;
	private String reference;
	private String currency;
	private double quote;
	private double amount;

	public String getOfficerNameDisbursement() {
		return officerNameDisbursement;
	}

	public void setOfficerNameDisbursement(String officerNameDisbursement) {
		this.officerNameDisbursement = officerNameDisbursement;
	}

	public String getDisbursementrate() {
		return disbursementrate;
	}

	public void setDisbursementrate(String disbursementrate) {
		this.disbursementrate = disbursementrate;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public double getQuote() {
		return quote;
	}

	public void setQuote(double quote) {
		this.quote = quote;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

}