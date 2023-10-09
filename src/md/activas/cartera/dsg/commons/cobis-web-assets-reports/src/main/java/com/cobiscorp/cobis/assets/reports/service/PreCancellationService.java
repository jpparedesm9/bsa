package com.cobiscorp.cobis.assets.reports.service;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.PreCancellationResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.dto.PrecancellationResponseDTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class PreCancellationService extends BaseService {

	private static final ILogger LOGGER = LogFactory.getLogger(PreCancellationService.class);

	public PrecancellationResponseDTO queryPreCancellation(LoanRequest loanRequest, ICTSServiceIntegration serviceIntegration) {
		PreCancellationResponse preCancellationResponse = null;
		ReferenceResponse[] referencesResponse = null;
		ServiceResponseTO serviceResponseTo = null;
		PrecancellationResponseDTO precancellationDTO = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_READ_PRECANCELLATION);
			serviceReportRequestTO.getData().put(ConstantValue.IN_LOAN_REQUEST, loanRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					preCancellationResponse = (PreCancellationResponse) serviceResponseTo.getValue(ConstantValue.RETURN_PRECANCELLATION_RESPONSE);
					referencesResponse = (ReferenceResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_REFERENCE_RESPONSE);
					LOGGER.logDebug("preCancellationResponse" + preCancellationResponse);
					LOGGER.logDebug("referencesResponse" + referencesResponse);
					precancellationDTO = new PrecancellationResponseDTO(preCancellationResponse, referencesResponse);
				} else {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("Error ejecucion servicio preCancenllationPayment");
					}
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logError("Error en queryPreCancellation: " + ex);

			}
			util.error(serviceResponseTo);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finaliza queryPreCancellation");
			}
		}
		return precancellationDTO;

	}
}
