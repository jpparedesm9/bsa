package com.cobiscorp.ecobis.cloud.service;

import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.cloud.service.dto.PaymentRequestDTO;

public interface B2BPaymentService {

	public Response applyPayment(PaymentRequestDTO paymentRequestDTO);
}
