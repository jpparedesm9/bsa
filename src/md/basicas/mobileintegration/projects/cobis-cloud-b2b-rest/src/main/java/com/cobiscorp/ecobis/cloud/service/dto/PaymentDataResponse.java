package com.cobiscorp.ecobis.cloud.service.dto;

import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;

import cobiscorp.ecobis.businesstobusiness.dto.PaymentResponse;

public class PaymentDataResponse {

	private Integer entityId;
	private Double precancelationAmount;
	private String reference;
	private String expirationPaymentDate;// Calendar
	private String emailAdress;
	private String lastPaymentId;
	private Double suggestedAmount;

	public static PaymentDataResponse fromResponse(PaymentResponse paymentResponse) {
		if(paymentResponse == null){
			return null;
		}
		PaymentDataResponse paymentDataResponse = new PaymentDataResponse();		
		paymentDataResponse.setEntityId(paymentResponse.getEntityId());
		paymentDataResponse.setPrecancelationAmount(paymentResponse.getPrecancelationAmount() == null ? null : paymentResponse.getPrecancelationAmount().doubleValue());
		paymentDataResponse.setReference(paymentResponse.getReference());
		paymentDataResponse.setExpirationPaymentDate( CalendarUtil.toISOTime(paymentResponse.getExpirationPaymentDate()));
		paymentDataResponse.setEmailAdress(paymentResponse.getEmailAdress());
		paymentDataResponse.setLastPaymentId(paymentResponse.getLastPaymentId());
		paymentDataResponse.setSuggestedAmount(paymentResponse.getSuggestedAmount() == null ? null : paymentResponse.getSuggestedAmount().doubleValue());
		return paymentDataResponse;
	}

	public Integer getEntityId() {
		return entityId;
	}

	public void setEntityId(Integer entityId) {
		this.entityId = entityId;
	}

	public Double getPrecancelationAmount() {
		return precancelationAmount;
	}

	public void setPrecancelationAmount(Double precancelationAmount) {
		this.precancelationAmount = precancelationAmount;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public String getExpirationPaymentDate() {
		return expirationPaymentDate;
	}

	public void setExpirationPaymentDate(String expirationPaymentDate) {
		this.expirationPaymentDate = expirationPaymentDate;
	}

	public String getEmailAdress() {
		return emailAdress;
	}

	public void setEmailAdress(String emailAdress) {
		this.emailAdress = emailAdress;
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

}
