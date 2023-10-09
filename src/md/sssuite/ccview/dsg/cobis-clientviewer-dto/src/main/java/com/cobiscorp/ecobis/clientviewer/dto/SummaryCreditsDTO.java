package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO which is used in the method getMaxDebt
 * 
 * @author bbuendia
 * 
 */
public class SummaryCreditsDTO implements Serializable {
	private Integer customer;
	private String user;
	private Integer sequence;
	private String product;
	private Integer operation;
	private String operationType;
	private String opTypeDescription;
	private String lineNumber;
	private Date openingDate;
	private Date expirationDate;
	private String currencyDescription;
	private Double limitApproved;
	private Double usedAmount;
	private Double usedAmountLocalCurrency;
	private Double available;
	private Double availableLocalCurrency;
	private Float rate;
	private Double contractAmount;
	private Double riskAmount;
	private String status;
	private String debtType;
	private String conType;
	private String customerName;
	private Integer processIdD;
	private Integer term;
	private String termType;
	private String role;
	private String rotaryType;

	public SummaryCreditsDTO() {

	}

	public SummaryCreditsDTO(Integer customer, Integer operation, String operationType, String opTypeDescription, String lineNumber, Date openingDate,
			Date expirationDate, Integer currency, String currencyDescription, Double limitApproved, Double usedAmount, Double usedAmountLocalCurrency,
			Double available, Double availableLocalCurrency, Float rate, Double contractAmount, String status, String customerName, Double riskAmount,
			String product, Integer term, String termType) {
		this.customer = customer;
		this.operation = operation;
		this.operationType = operationType;
		this.opTypeDescription = opTypeDescription;
		this.lineNumber = lineNumber;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.currencyDescription = currencyDescription;
		this.limitApproved = limitApproved;
		this.usedAmount = usedAmount;
		this.usedAmountLocalCurrency = usedAmountLocalCurrency;
		this.available = available;
		this.availableLocalCurrency = availableLocalCurrency;
		this.rate = rate;
		this.contractAmount = contractAmount;
		this.status = status;
		this.customerName = customerName;
		this.riskAmount = riskAmount;
		this.product = product;
		this.term = term;
		this.termType = termType;
	}
	
	public SummaryCreditsDTO(Integer customer, Integer operation, String operationType, String opTypeDescription, String lineNumber, Date openingDate,
			Date expirationDate, Integer currency, String currencyDescription, Double limitApproved, Double usedAmount, Double usedAmountLocalCurrency,
			Double available, Double availableLocalCurrency, Float rate, Double contractAmount, String status, String customerName, Double riskAmount,
			String product, Integer term, String termType, String role, String rotaryType) {
		this.customer = customer;
		this.operation = operation;
		this.operationType = operationType;
		this.opTypeDescription = opTypeDescription;
		this.lineNumber = lineNumber;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.currencyDescription = currencyDescription;
		this.limitApproved = limitApproved;
		this.usedAmount = usedAmount;
		this.usedAmountLocalCurrency = usedAmountLocalCurrency;
		this.available = available;
		this.availableLocalCurrency = availableLocalCurrency;
		this.rate = rate;
		this.contractAmount = contractAmount;
		this.status = status;
		this.customerName = customerName;
		this.riskAmount = riskAmount;
		this.product = product;
		this.term = term;
		this.termType = termType;
		this.role = role;
		this.rotaryType = rotaryType;
	}

	public SummaryCreditsDTO(Integer customer, String user, Integer sequence, String product, Integer operation, String operationType,
			String opTypeDescription, String lineNumber, Date openingDate, Date expirationDate, Double limitApproved, Double usedAmount,
			Double usedAmountLocalCurrency, Double available, Double availableLocalCurrency, Float rate, Double contractAmount, Double riskAmount,
			String status, String debtType, String conType, Integer processIdD, Integer term, String termType) {
		this.customer = customer;
		this.user = user;
		this.sequence = sequence;
		this.product = product;
		this.operation = operation;
		this.operationType = operationType;
		this.opTypeDescription = opTypeDescription;
		this.lineNumber = lineNumber;
		this.openingDate = openingDate;
		this.expirationDate = expirationDate;
		this.limitApproved = limitApproved;
		this.usedAmount = usedAmount;
		this.usedAmountLocalCurrency = usedAmountLocalCurrency;
		this.available = available;
		this.availableLocalCurrency = availableLocalCurrency;
		this.rate = rate;
		this.contractAmount = contractAmount;
		this.riskAmount = riskAmount;
		this.status = status;
		this.debtType = debtType;
		this.conType = conType;
		this.processIdD = processIdD;
		this.term = term;
		this.termType = termType;
	}

	public SummaryCreditsDTO(Integer customer, String user, Integer sequence, Double riskAmount, String conType) {
		this.customer = customer;
		this.user = user;
		this.sequence = sequence;
		this.riskAmount = riskAmount;
		this.conType = conType;
	}

	public Integer getCustomer() {
		return customer;
	}

	public void setCustomer(Integer customer) {
		this.customer = customer;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public Integer getOperation() {
		return operation;
	}

	public void setOperation(Integer operation) {
		this.operation = operation;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public String getOpTypeDescription() {
		return opTypeDescription;
	}

	public void setOpTypeDescription(String opTypeDescription) {
		this.opTypeDescription = opTypeDescription;
	}

	public String getLineNumber() {
		return lineNumber;
	}

	public void setLineNumber(String lineNumber) {
		this.lineNumber = lineNumber;
	}

	public Date getOpeningDate() {
		return openingDate;
	}

	public void setOpeningDate(Date openingDate) {
		this.openingDate = openingDate;
	}

	public Date getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(Date expirationDate) {
		this.expirationDate = expirationDate;
	}

	public String getCurrencyDescription() {
		return currencyDescription;
	}

	public void setCurrencyDescription(String currencyDescription) {
		this.currencyDescription = currencyDescription;
	}

	public Double getLimitApproved() {
		return limitApproved;
	}

	public void setLimitApproved(Double limitApproved) {
		this.limitApproved = limitApproved;
	}

	public Double getUsedAmount() {
		return usedAmount;
	}

	public void setUsedAmount(Double usedAmount) {
		this.usedAmount = usedAmount;
	}

	public Double getUsedAmountLocalCurrency() {
		return usedAmountLocalCurrency;
	}

	public void setUsedAmountLocalCurrency(Double usedAmountLocalCurrency) {
		this.usedAmountLocalCurrency = usedAmountLocalCurrency;
	}

	public Double getAvailable() {
		return available;
	}

	public void setAvailable(Double available) {
		this.available = available;
	}

	public Double getAvailableLocalCurrency() {
		return availableLocalCurrency;
	}

	public void setAvailableLocalCurrency(Double availableLocalCurrency) {
		this.availableLocalCurrency = availableLocalCurrency;
	}

	public Float getRate() {
		return rate;
	}

	public void setRate(Float rate) {
		this.rate = rate;
	}

	public Double getContractAmount() {
		return contractAmount;
	}

	public void setContractAmount(Double contractAmount) {
		this.contractAmount = contractAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public Double getRiskAmount() {
		return riskAmount;
	}

	public void setRiskAmount(Double riskAmount) {
		this.riskAmount = riskAmount;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getConType() {
		return conType;
	}

	public void setConType(String conType) {
		this.conType = conType;
	}

	public Integer getProcessIdD() {
		return processIdD;
	}

	public void setProcessIdD(Integer processIdD) {
		this.processIdD = processIdD;
	}

	public Integer getTerm() {
		return term;
	}

	public void setTerm(Integer term) {
		this.term = term;
	}

	public String getTermType() {
		return termType;
	}

	public void setTermType(String termType) {
		this.termType = termType;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRotaryType() {
		return rotaryType;
	}

	public void setRotaryType(String rotaryType) {
		this.rotaryType = rotaryType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + customer;
		result = prime * result + sequence;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SummaryCreditsDTO other = (SummaryCreditsDTO) obj;
		if (customer != other.customer)
			return false;
		if (sequence != other.sequence)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SummaryCredits [customer=" + customer + ", user=" + user + ", sequence=" + sequence + ", product=" + product + ", operation=" + operation
				+ ", operationType=" + operationType + ", opTypeDescription=" + opTypeDescription + ", lineNumber=" + lineNumber + ", openingDate="
				+ openingDate + ", expirationDate=" + expirationDate + ", currencyDescription=" + currencyDescription + ", limitApproved=" + limitApproved
				+ ", usedAmount=" + usedAmount + ", usedAmountLocalCurrency=" + usedAmountLocalCurrency + ", available=" + available
				+ ", availableLocalCurrency=" + availableLocalCurrency + ", rate=" + rate + ", contractAmount=" + contractAmount + ", riskAmount=" + riskAmount
				+ ", status=" + status + ", debtType=" + debtType + ", conType=" + conType + ", customerName=" + customerName + ", processIdD=" + processIdD
				+ "]";
	}

}
