package com.cobiscorp.cobis.assets.reports.service;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.dto.PaymentCardDTO;
import com.cobiscorp.cobis.assets.reports.dto.PrecancellationResponseDTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.PaymentCardDetailResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentCardHeaderResponse;
import cobiscorp.ecobis.assets.cloud.dto.PaymentCardRequest;
import cobiscorp.ecobis.assets.cloud.dto.PreCancellationResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class PaymentCardService extends BaseService{
	
	private static final ILogger LOGGER = LogFactory.getLogger(PaymentCardService.class);
	
	public PaymentCardDTO queryPaymentcard(PaymentCardRequest paymentCardRequest, ICTSServiceIntegration serviceIntegration) {
		PaymentCardHeaderResponse[] paymentCardHeaderResponse = null;
		PaymentCardDetailResponse[] paymentCardDetailResponse = null;
		

		ServiceResponseTO serviceResponseTo = null;
		PaymentCardDTO paymentCardDTO = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_READ_PAYMENT_CARD);
			serviceReportRequestTO.getData().put(ConstantValue.IN_PAYMENT_CARD, paymentCardRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					paymentCardHeaderResponse = (PaymentCardHeaderResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_PAYMENT_CARD_HEADER);
					paymentCardDetailResponse = (PaymentCardDetailResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_PAYMENT_CARD_DETAIL);
					
					LOGGER.logDebug("paymentCardHeaderResponse" + paymentCardHeaderResponse);
					LOGGER.logDebug("paymentCardDetailResponse" + paymentCardDetailResponse);
					paymentCardDTO = new PaymentCardDTO(paymentCardHeaderResponse[0], paymentCardDetailResponse);
				} else {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("Error ejecucion servicio preCancenllationPayment");
					}
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logError("Error en queryPaymentCard: " + ex);

			}
			util.error(serviceResponseTo);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza queryPaymentCard");
			}
		}
		return paymentCardDTO;
		
	}
	

}
