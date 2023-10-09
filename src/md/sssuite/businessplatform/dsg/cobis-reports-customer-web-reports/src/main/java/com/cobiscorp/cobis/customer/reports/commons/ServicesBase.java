package com.cobiscorp.cobis.customer.reports.commons;

import java.util.List;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;

public class ServicesBase {
	private static final ILogger logger = LogFactory.getLogger(ServicesBase.class);
	protected String sessionId;
	protected ICTSServiceIntegration serviceIntegration;

	public ServicesBase() {
	}

	public ServicesBase(String sessionId) {
		this.sessionId = sessionId;
	}

	public ServicesBase(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public ServicesBase(String sessionId, ICTSServiceIntegration serviceIntegration) {
		this.sessionId = sessionId;
		this.serviceIntegration = serviceIntegration;
	}

	protected ServiceRequestTO getHeaderRequest(String serviceId) {
		return getHeaderRequest(this.sessionId, serviceId);
	}

	protected ServiceRequestTO getHeaderRequest(String sessionId, String serviceId) {
		ServiceRequest headerRequest = new ServiceRequest();
		headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
		serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
		serviceReportRequestTO.setSessionId(sessionId);
		serviceReportRequestTO.setServiceId(serviceId);
		return serviceReportRequestTO;
	}

	@SuppressWarnings("unchecked")
	protected void managementExeption(String reference, ServiceResponseTO serviceResponseParameter){
		if (serviceResponseParameter.getMessages() != null && serviceResponseParameter.getMessages().size() > 0) {
			List<MessageTO> errorMessages = serviceResponseParameter.getMessages();
			String error = "[REFERENCIA:(" + reference + ")]  ";
			for (MessageTO message : errorMessages) {
				error = error + "  [CODIGO:(" + message.getCode() + ") , MENSAJE:(";
				error = error + message.getMessage() + ")]  ";
			}
			logger.logError("GENERATE EXCEPTION IN REPORTS" + error);
		}
	}

}
