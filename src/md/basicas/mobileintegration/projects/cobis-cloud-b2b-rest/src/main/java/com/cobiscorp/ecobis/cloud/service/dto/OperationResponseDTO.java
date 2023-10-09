package com.cobiscorp.ecobis.cloud.service.dto;

import cobiscorp.ecobis.businesstobusiness.dto.OperationResponse;

public class OperationResponseDTO {
	private String operationNumber;
	private String operationType;
	private Double paymentAmount;
	private Double maxAmount;
	private Double minAmount;
	private String reference;
	private Long expirationPaymentDate;
	private String emailAddress;
	private String lastPaymentId;
	private Double suggestedAmount;
	private String customerGroupName;

	public void fromResponse(OperationResponse operationResponse) {
		if (operationResponse != null) {

			this.operationNumber = operationResponse.getOperationNumber();
			this.operationType = operationResponse.getOperationType();
			this.paymentAmount = operationResponse.getPaymentAmount();
			this.maxAmount = operationResponse.getMaxAmount();
			this.minAmount = operationResponse.getMinAmount();
			this.reference = operationResponse.getReference();
			this.expirationPaymentDate = operationResponse.getExpirationPaymentDate() == null ? null : operationResponse.getExpirationPaymentDate().getTimeInMillis();
			this.emailAddress = operationResponse.getEmailAddress();
			this.suggestedAmount = operationResponse.getSuggestedAmount();
			this.customerGroupName = operationResponse.getCustomerGroupName();
			this.lastPaymentId = operationResponse.getLastPaymentId();
		}
	}

	public String getOperationNumber() {
		return operationNumber;
	}

	public void setOperationNumber(String operationNumber) {
		this.operationNumber = operationNumber;
	}

	public String getOperationType() {
		return operationType;
	}

	public void setOperationType(String operationType) {
		this.operationType = operationType;
	}

	public Double getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public Double getMaxAmount() {
		return maxAmount;
	}

	public void setMaxAmount(Double maxAmount) {
		this.maxAmount = maxAmount;
	}

	public Double getMinAmount() {
		return minAmount;
	}

	public void setMinAmount(Double minAmount) {
		this.minAmount = minAmount;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public Long getExpirationPaymentDate() {
		return expirationPaymentDate;
	}

	public void setExpirationPaymentDate(Long expirationPaymentDate) {
		this.expirationPaymentDate = expirationPaymentDate;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getLastPaymentId() {
		return lastPaymentId;
	}

	public void setLastPaymentId(String lastPaymentId) {
		this.lastPaymentId = lastPaymentId;
	}

	public Double getSuggestedAmount() {
		return suggestedAmount;
	}

	public void setSuggestedAmount(Double suggestedAmount) {
		this.suggestedAmount = suggestedAmount;
	}

	public String getCustomerGroupName() {
		return customerGroupName;
	}

	public void setCustomerGroupName(String customerGroupName) {
		this.customerGroupName = customerGroupName;
	}

	@Override
	public String toString() {
		return "OperationResponseDTO [operationNumber=" + operationNumber + ", operationType=" + operationType + ", paymentAmount=" + paymentAmount + ", maxAmount=" + maxAmount
				+ ", minAmount=" + minAmount + ", reference=" + reference + ", expirationPaymentDate=" + expirationPaymentDate + ", emailAddress=" + emailAddress
				+ ", lastPaymentId=" + lastPaymentId + ", suggestedAmount=" + suggestedAmount + ", customerGroupName=" + customerGroupName + "]";
	}

}
