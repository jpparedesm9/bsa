package com.cobiscorp.ecobis.cloud.service.dto;

public class PaymentsResponse {
	private PaymentDataResponse paymentResponse;

	public PaymentsResponse() {

	}

	public PaymentsResponse(PaymentDataResponse paymentResponse) {
		this.paymentResponse = paymentResponse;
	}

	public PaymentDataResponse getPaymentResponse() {
		return paymentResponse;
	}

	public void setPaymentResponse(PaymentDataResponse paymentResponse) {
		this.paymentResponse = paymentResponse;
	}

}
