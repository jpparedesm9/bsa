package com.cobiscorp.cobis.customer.reports.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCreditsSummaryPrincipalResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCreditsSummaryResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistCustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistDetailConsultationsResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistDetailTheCreditsResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistEmployeeHomeResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportHistScoreBuroResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportIEAddressResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.customer.reports.commons.ConstantValue;
import com.cobiscorp.cobis.customer.reports.commons.Method;
import com.cobiscorp.cobis.customer.reports.commons.Services;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;

public class BuroCreditoHistoricalServices {
	private static final ILogger logger = LogFactory.getLogger(BuroCreditoHistoricalServices.class);
	private static Method method = new Method();
	private static Services services = new Services();
	String sessionId = SessionManager.getSessionId();
	
	// Buro Historial - Datos Cliente
	public ReportHistCustomerResponse[] histoCustomer(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histoCustomer";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_CUSTOMER_RESPONSE;
		try {

			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistCustomerResponse - " + methodName + " = isSuccess");
				ReportHistCustomerResponse[] response = (ReportHistCustomerResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistCustomerResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistCustomerResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistCustomerResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistCustomerResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Direccion
	public ReportIEAddressResponse[] histoAddress(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histoAddress";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_IE_ADDRESS_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

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
			logger.logError("----->>>Services Error " + methodName + "- ReportIEAddressResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportIEAddressResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportIEAddressResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Direccion Empleados
	public ReportHistEmployeeHomeResponse[] histAddressEmpl(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histAddressEmpl";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_EMPLOYEE_HOME_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistEmployeeHomeResponse - " + methodName + " = isSuccess");
				ReportHistEmployeeHomeResponse[] response = (ReportHistEmployeeHomeResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistEmployeeHomeResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistEmployeeHomeResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistEmployeeHomeResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistEmployeeHomeResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Detalle del credito
	public ReportHistDetailTheCreditsResponse[] histDatailCred(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histDatailCred";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_DETAIL_THECREDITS_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistDetailTheCreditsResponse - " + methodName + " = isSuccess");
				ReportHistDetailTheCreditsResponse[] response = (ReportHistDetailTheCreditsResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistDetailTheCreditsResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistDetailTheCreditsResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistDetailTheCreditsResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistDetailTheCreditsResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Suma del Credito (debajo de la grilla de sumatoria)
	public ReportHistCreditsSummaryResponse[] histSummaryCred(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histSummaryCred";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_CREDITS_SUMMARY_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio - " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistCreditsSummaryResponse - " + methodName + " = isSuccess");
				ReportHistCreditsSummaryResponse[] response = (ReportHistCreditsSummaryResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistCreditsSummaryResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistCreditsSummaryResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistCreditsSummaryResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistCreditsSummaryResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Suma del Credito (Grilla de sumatoria)
	public ReportHistCreditsSummaryPrincipalResponse[] histPrincipalSummaryCred(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histPrincipalSummaryCred";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_CREDITS_SUMMARY_PRINCIPAL_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistCreditsSummaryPrincipalResponse - " + methodName + " = isSuccess");
				ReportHistCreditsSummaryPrincipalResponse[] response = (ReportHistCreditsSummaryPrincipalResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistCreditsSummaryPrincipalResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistCreditsSummaryPrincipalResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistCreditsSummaryPrincipalResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistCreditsSummaryPrincipalResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Detalle de consulta
	public ReportHistDetailConsultationsResponse[] histDetailConsultations(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histDetailConsultations";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_DETAIL_CONSULTATIONS_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistDetailConsultationsResponse - " + methodName + " = isSuccess");
				ReportHistDetailConsultationsResponse[] response = (ReportHistDetailConsultationsResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistDetailConsultationsResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistDetailConsultationsResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistDetailConsultationsResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistDetailConsultationsResponse - " + serviceId);
		}
		return null;
	}

	// Buro Historial - Score Buro
	public ReportHistScoreBuroResponse[] histScoreBuro(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		String methodName = "histScoreBuro";
		String serviceId = ConstantValue.serviceName.BURO_CREDIT_HISTORY_REPORT;
		String dtoResquest = ConstantValue.requestName.REPORT_REQUEST;
		String dtoResponse = ConstantValue.returnName.REPORT_HIST_SCORE_BURO_RESPONSE;
		try {
			logger.logDebug("----->>>BuroCreditoHistoricalServices Inicio- " + methodName + " - Servicio:" + serviceId + "-DTO-" + dtoResponse);

			ServiceRequest headerRequest = new ServiceRequest();
			headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
			ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
			serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
			serviceReportRequestTO.setSessionId(sessionId);
			serviceReportRequestTO.setServiceId(serviceId);
			serviceReportRequestTO.getData().put(dtoResquest, reportRequest);

			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTO.isSuccess()) {
				logger.logDebug("----->>>Services - ReportHistScoreBuroResponse - " + methodName + " = isSuccess");
				ReportHistScoreBuroResponse[] response = (ReportHistScoreBuroResponse[]) serviceResponseTO.getValue(dtoResponse);
				return response;
			} else {
				logger.logDebug("----->>>Services - ReportHistScoreBuroResponse - " + methodName + " !=isSuccess");
				method.error(serviceResponseTO);
				services.managementExeption(serviceId, serviceResponseTO);
			}
		} catch (Exception ex) {
			logger.logError("----->>>Services Error " + methodName + "- ReportHistScoreBuroResponse - " + serviceId, ex);
			throw new RuntimeException("----->>>Services Error " + methodName + "- ReportHistScoreBuroResponse - " + serviceId, ex);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("----->>>Services Finaliza " + methodName + " - ReportHistScoreBuroResponse - " + serviceId);
		}
		return null;
	}

}
