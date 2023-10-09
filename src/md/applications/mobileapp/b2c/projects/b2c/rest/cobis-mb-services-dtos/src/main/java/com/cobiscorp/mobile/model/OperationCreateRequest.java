package com.cobiscorp.mobile.model;

import java.util.Calendar;

public class OperationCreateRequest extends BaseRequest {

	private Double amount;
	private Integer term;
	private String periodicity;
	private Integer client;
	private String operationType;
	private Integer currency;
	private Calendar iniDate;
	private Float rate;
	private Double amountMax;

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

	public Calendar getIniDate() {
		return iniDate;
	}

	public void setIniDate(Calendar iniDate) {
		this.iniDate = iniDate;
	}

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Double getAmountMax() {
		return amountMax;
	}

	public void setAmountMax(Double amountMax) {
		this.amountMax = amountMax;
	}

	@Override
	public String toString() {
		return "OperationRequest [amount=" + amount + ", term=" + term + ", periodicity=" + periodicity + ", client=" + client + ", operationType=" + operationType + ", currency=" + currency
				+ ", iniDate=" + iniDate + ", rate=" + rate + ", amountMax=" + amountMax + "]";
	}

}
