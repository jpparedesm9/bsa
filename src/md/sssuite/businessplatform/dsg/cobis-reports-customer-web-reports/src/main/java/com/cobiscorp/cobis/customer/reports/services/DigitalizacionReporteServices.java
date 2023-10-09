package com.cobiscorp.cobis.customer.reports.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIECustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;
import cobiscorp.ecobis.loangroup.dto.ScannedDocumentsRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.customer.reports.commons.ConstantValue;
import com.cobiscorp.cobis.customer.reports.commons.Method;
import com.cobiscorp.cobis.customer.reports.commons.Services;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

public class DigitalizacionReporteServices {
	
	private static final ILogger logger = LogFactory.getLogger(DigitalizacionReporteServices.class);
	private static Method method = new Method();
	private static Services services = new Services();
	String sessionId = SessionManager.getSessionId();
	
	public void digitalizarReport(String sessionId, ScannedDocumentsRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "digitalizarReport";
		String serviceId = ConstantValue.serviceName.SCANNED_DOCUMENTS;
		String dtoResquest = ConstantValue.requestName.SCANNED_DOCUMENTS_REQUEST;
		try {
			logger.logDebug("----->>>DigitalizacionReporteServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResquest);
           	ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);
			
			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - DigitalizacionReporteServices - " + methodName + " = isSuccess");
			} else {
				logger.logDebug("----->>>Services - DigitalizacionReporteServices - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}			
		}catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportIECustomerResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportIECustomerResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportIECustomerResponse - " + serviceId);
		}
		
		
		
		
	}

}
