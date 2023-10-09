package com.cobiscorp.ecobis.clientviewer.report.service;


import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.clientviewer.report.dto.AdvisorReportDto;
import com.cobiscorp.ecobis.report.util.Constants;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.collective.dto.AdvisorExternalResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class AdvisorReportService extends BaseService {
	
	private static final ILogger logger = LogFactory.getLogger(AdvisorReportService.class);
	
	
	public AdvisorExternalResponse[] queryAdvisorExecl(AdvisorExternalRequest advisorExternalRequest, ICTSServiceIntegration serviceIntegration) {
		
		logger.logDebug("Inicia  queryAdvisorExecl");
		AdvisorExternalResponse[] advisorExternalResponse = null;
		List<AdvisorReportDto> advisorResponse = new ArrayList<AdvisorReportDto>();
		logger.logDebug("queryAdvisorExecl 0");
		try {
			logger.logDebug("advisorExternalRequest 1"+advisorExternalRequest.getOperation());
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(Constants.QUERRY_COLECTIVE);
			serviceReportRequestTO.getData().put(Constants.IN_ADVISOR_EXTERNAL_REQUEST, advisorExternalRequest);
			logger.logDebug("serviceReportRequestTO 1"+serviceReportRequestTO.getSessionId());
			logger.logDebug("serviceReportRequestTO 2"+serviceReportRequestTO.getServiceId());
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			logger.logDebug("serviceResponseTo 0.1");
			if (serviceResponseTo != null) {
				logger.logDebug("queryAdvisorExecl 2");
				if (serviceResponseTo.isSuccess()) {
					logger.logDebug("queryAdvisorExecl 3");
					advisorExternalResponse = (AdvisorExternalResponse[]) serviceResponseTo.getValue(Constants.RETURN_QUERRYCOLECTIVE);
					for (AdvisorExternalResponse asesorInfo : advisorExternalResponse) {
						logger.logDebug("queryAdvisorExecl 4");
							logger.logDebug("getCustomerId id: " + asesorInfo.getCustomerId());
							logger.logDebug("getCustomerName id: " + asesorInfo.getCustomerName());				
					}

				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Error ejecucion servicio queryCollateralPayment");
					}
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled()) {
				logger.logError("Error en queryCollateralPayment: " ,ex);

			}
			//util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza queryCollateralPayment");
			}
		}
		return advisorExternalResponse;
	}

}
