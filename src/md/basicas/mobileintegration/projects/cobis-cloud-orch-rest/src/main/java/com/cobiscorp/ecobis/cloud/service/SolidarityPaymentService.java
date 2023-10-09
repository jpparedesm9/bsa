package com.cobiscorp.ecobis.cloud.service;

import com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment.SolidarityPaymentRequest;

import javax.ws.rs.core.Response;

/**
 * Created by farid on 7/24/2017.
 */
public interface SolidarityPaymentService {
    Response createSolidarityPayment(SolidarityPaymentRequest request);
}
