package com.cobiscorp.cobis.customer.reports.commons;

import java.util.List;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;

public class Services {
	private static final ILogger logger = LogFactory.getLogger(Services.class);
	private static Method method = new Method();

	@SuppressWarnings("unchecked")
	public void managementExeption(String reference, ServiceResponseTO serviceResponseParameter) {
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

	// Buro Historial - Score Buro
	public void updateBuroMistake(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "updateBuroMistake";
		String serviceId = ConstantValue.serviceName.UPDATE_BURO_MISTAKE;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		Boolean flag = false;
		try {
			logger.logDebug("----->>>Services Inicio- " + methodName + " - Servicio:" + serviceId);

			logger.logDebug("----->>>AAAA-Services sessionId:- " + sessionId);
			logger.logDebug("----->>>AAAA-Services serviceIntegration:- " + serviceIntegration);
			
			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services " + methodName + " = isSuccess");
				flag = true;
			} else {
				logger.logDebug("----->>>Services " + methodName + " != isSuccess");
				method.error(serviceResponseTO);
				managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {			
			logger.logError("----->>>Services Error " + serviceId +"-"+ methodName, ex);
			throw new RuntimeException("----->>>Services Error " + serviceId +"-"+ methodName , ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + serviceId + "Metodo:" + methodName);
		}
	}
}
