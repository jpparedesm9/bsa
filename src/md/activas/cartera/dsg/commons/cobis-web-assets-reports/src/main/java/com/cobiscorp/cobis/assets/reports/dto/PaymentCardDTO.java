package com.cobiscorp.cobis.assets.reports.dto;

import cobiscorp.ecobis.assets.cloud.dto.PaymentCardDetailResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentCardHeaderResponse;
import cobiscorp.ecobis.assets.cloud.dto.PreCancellationResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;

public class PaymentCardDTO {
	
	private PaymentCardHeaderResponse paymentCardHeaderResponse;
	private PaymentCardDetailResponse[] paymentCardDetailResponse;
	
	public PaymentCardDTO(PaymentCardHeaderResponse paymentCardHeaderResponse, PaymentCardDetailResponse[] paymentCardDetailResponse) {
		this.paymentCardHeaderResponse = paymentCardHeaderResponse;
		this.paymentCardDetailResponse = paymentCardDetailResponse;
	}

	public PaymentCardHeaderResponse getPaymentCardHeaderResponse() {
		return paymentCardHeaderResponse;
	}

	public void setPaymentCardHeaderResponse(PaymentCardHeaderResponse paymentCardHeaderResponse) {
		this.paymentCardHeaderResponse = paymentCardHeaderResponse;
	}

	public PaymentCardDetailResponse[] getPaymentCardDetailResponse() {
		return paymentCardDetailResponse;
	}

	public void setPaymentCardDetailResponse(PaymentCardDetailResponse[] paymentCardDetailResponse) {
		this.paymentCardDetailResponse = paymentCardDetailResponse;
	}

	
	
	
}
