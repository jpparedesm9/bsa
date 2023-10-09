package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import java.math.BigDecimal;
import java.util.Calendar;

public class Simulation {

	private BigDecimal amount;
	private Integer term;
	private String periodicity;
	private String operationType;
	private String subType;
	private Integer currency;
	private Calendar iniDate;
	private double rate;
	private BigDecimal quota;

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
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

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
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

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public BigDecimal getQuota() {
		return quota;
	}

	public void setQuota(BigDecimal quota) {
		this.quota = quota;
	}

}
