package com.cobiscorp.ecobis.cloud.service.dto;

public class PaymentRequestDTO {

	private String reference;
	private Double paymentAmount;
	private String correspondent;
	private String trnIdCorrespondent;
	private String paymentUser;
	private String paymentDate;
	
	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public Double getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(Double paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public String getCorrespondent() {
		return correspondent;
	}

	public void setCorrespondent(String correspondent) {
		this.correspondent = correspondent;
	}

	public String getTrnIdCorrespondent() {
		return trnIdCorrespondent;
	}

	public void setTrnIdCorrespondent(String trnIdCorrespondent) {
		this.trnIdCorrespondent = trnIdCorrespondent;
	}

	public String getPaymentUser() {
		return paymentUser;
	}

	public void setPaymentUser(String paymentUser) {
		this.paymentUser = paymentUser;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	
	

}
