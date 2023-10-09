package com.cobiscorp.mobile.model;

import java.util.Date;

public class SimulationRequest extends BaseRequest {

	private Double amount;
	private Integer term;
	private String periodicity;
	private Integer client;
	private String operationType;
	private Integer currency;
	private String iniDate;
	private Double rate;

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public String getPeriodicity() {
		return periodicity;
	}

	public void setPeriodicity(String periodicity) {
		this.periodicity = periodicity;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public String getIniDate() {
		return iniDate;
	}

	public void setIniDate(String iniDate) {
		this.iniDate = iniDate;
	}

	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}

	@Override
	public String toString() {
		return "SimulationRequest [amount=" + amount + ", term=" + term + ", periodicity=" + periodicity + ", client=" + client + ", operationType=" + operationType + ", currency="
				+ currency + ", iniDate=" + iniDate + ", rate=" + rate + "]";
	}

}
