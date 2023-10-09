package com.cobiscorp.cobis.customer.reports.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAccountClientResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIECustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIELoanResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.customer.reports.commons.ConstantValue;
import com.cobiscorp.cobis.customer.reports.commons.Method;
import com.cobiscorp.cobis.customer.reports.commons.Services;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

public class BuroCreditoInternoExternoServices {
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoInternoExternoServices.class);
	private static Method method = new Method();
	private static Services services = new Services();
	String sessionId = SessionManager.getSessionId();

	// Buro interno externo - DatosCliente
	public ReportIECustomerResponse[] reportIECustomer(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "reportIECustomer";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_INTERNAL_EXTERNAL_CREDIT_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_IE_CUSTOMER_RESPONSE;
		try {

			logger.logDebug("----->>>BuroCreditoInternoExternoServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportIECustomerResponse - " + methodName + " = isSuccess");
				ReportIECustomerResponse[] response = (ReportIECustomerResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportIECustomerResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportIECustomerResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportIECustomerResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportIECustomerResponse - " + serviceId);
		}
		return null;
	}

	public ReportIEAddressResponse[] reportIEAddressClient(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "reportIEAddressClient";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_INTERNAL_EXTERNAL_CREDIT_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_IE_ADDRESS_RESPONSE;

		try {
			logger.logDebug("----->>>BuroCreditoInternoExternoServicesInicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportIEAddressResponse - " + methodName + " = isSuccess");
				ReportIEAddressResponse[] response = (ReportIEAddressResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportIEAddressResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + " - ReportIEAddressResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + " - ReportIEAddressResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportIEAddressResponse - " + serviceId);
		}
		return null;
	}

	// Buro interno externo - Historico
	public ReportIELoanResponse[] reportIEHistorical(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "reportIEHistorical";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_INTERNAL_EXTERNAL_CREDIT_REPORT;
		String dtoRequest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_IE_LOAN_RESPONSE;

		try {
			logger.logDebug("----->>>BuroCreditoInternoExternoServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);
			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoRequest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportIELoanResponse - " + methodName + " = isSuccess");
				ReportIELoanResponse[] response = (ReportIELoanResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportIELoanResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + " - ReportIELoanResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + " - ReportIELoanResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportIELoanResponse - " + serviceId);
		}
		return null;
	}

	// Buro interno externo - SistemaFinanciero
	public ReportIEAccountClientResponse[] reportIEFinanceSystem(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "reportIEFinanceSystem";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_INTERNAL_EXTERNAL_CREDIT_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_IE_ACCOUNTCLIENT_RESPONSE;

		try {

			logger.logDebug("----->>>BuroCreditoInternoExternoServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportIEAccountClientResponse - " + methodName + " = isSuccess");
				ReportIEAccountClientResponse[] response = (ReportIEAccountClientResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportIEAccountClientResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + " - ReportIEAccountClientResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + " - ReportIEAccountClientResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportIEAccountClientResponse - " + serviceId);
		}
		return null;
	}
}
