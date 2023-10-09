package com.cobiscorp.cobis.assets.reports.service;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.dto.CorresponsalPaymentResponseDTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.CorresponsalPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.CorresponsalPaymentResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class CorresponsalPaymentService extends BaseService {

	private static final ILogger LOGGER = LogFactory.getLogger(CorresponsalPaymentService.class);

	public CorresponsalPaymentResponseDTO queryCorresponsalPayment(CorresponsalPaymentRequest corresponsalPaymentRequest, ICTSServiceIntegration serviceIntegration) {
		CorresponsalPaymentResponse corresponsalPaymentResponse = null;
		ReferenceResponse[] referencesResponse = null;
		ServiceResponseTO serviceResponseTo = null;
		CorresponsalPaymentResponseDTO corresponsalPaymentDTO = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_READ_CORRESPONSAL_PAYMENT);
			serviceReportRequestTO.getData().put(ConstantValue.IN_CORRESPONSAL_PAYMENT_REQUEST, corresponsalPaymentRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					corresponsalPaymentResponse = (CorresponsalPaymentResponse) serviceResponseTo.getValue(ConstantValue.RETURN_CORRESPONSAL_PAYMENT_RESPONSE);
					referencesResponse = (ReferenceResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_REFERENCE_RESPONSE);
					corresponsalPaymentDTO = new CorresponsalPaymentResponseDTO(corresponsalPaymentResponse, referencesResponse);
				} else {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("Error ejecucion servicio queryCorresponsalPayment");
					}
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logError("Error en queryCorresponsalPayment: ", ex);

			}
			util.error(serviceResponseTo);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza queryCorresponsalPayment");
			}
		}
		return corresponsalPaymentDTO;

	}

	public CorresponsalPaymentResponseDTO queryCorresponsalPaymentInd(CorresponsalPaymentRequest corresponsalPaymentRequest, ICTSServiceIntegration serviceIntegration) {
		CorresponsalPaymentResponse corresponsalPaymentResponse = null;
		ReferenceResponse[] referencesResponse = null;
		ServiceResponseTO serviceResponseTo = null;
		CorresponsalPaymentResponseDTO corresponsalPaymentDTO = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_READ_CORRESPONSAL_PAYMENT_IND);
			serviceReportRequestTO.getData().put(ConstantValue.IN_CORRESPONSAL_PAYMENT_REQUEST, corresponsalPaymentRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					corresponsalPaymentResponse = (CorresponsalPaymentResponse) serviceResponseTo.getValue(ConstantValue.RETURN_CORRESPONSAL_PAYMENT_RESPONSE);
					referencesResponse = (ReferenceResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_REFERENCE_RESPONSE);
					corresponsalPaymentDTO = new CorresponsalPaymentResponseDTO(corresponsalPaymentResponse, referencesResponse);
				} else {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("Error ejecucion servicio queryCorresponsalPayment");
					}
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logError("Error en queryCorresponsalPayment: ", ex);

			}
			util.error(serviceResponseTo);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza queryCorresponsalPayment");
			}
		}
		return corresponsalPaymentDTO;

	}
}
