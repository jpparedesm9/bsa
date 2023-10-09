package com.cobiscorp.cobis.loans.reports.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenAddressCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenBusinessCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenInfoCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportLongIndCreditGenReferensCustomerResponse;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;

public class ServicesLongIndividualCreditApplication {
	private static final ILogger logger = LogFactory.getLogger(ServicesLongIndividualCreditApplication.class);
	private static Method method = new Method();
	Services services = new Services();

	// @i_operacion = 'IG' -- Informacion General del Cliente
	public ReportLongIndCreditGenInfoCustomerResponse[] getInfoCustomer(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
		String requestDto = ConstantValue.RequestName.IN_REPORT_REQUEST;
		String responseDto = ConstantValue.ReturnName.REPORT_LONG_IND_CREDIT_GEN_INFO_CUSTOMER_RESPONSE;
		String nameServices = ConstantValue.ServiceName.LONG_INDIVIDUAL_CREDIT_APPLICATION_INFO_CUSTOMER;

		logger.logError("----->>> ServicesLongIndividualCreditApplication -> getInfoCustomer Inicio:" + nameServices + " idCliente:" + reportRequest.getCustomerId());

		ServiceRequestTO serviceRequestTO = services.getHeaderRequest(sessionId, nameServices);

		serviceRequestTO.addValue(requestDto, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getInfoCustomer isSuccess ");
			return (ReportLongIndCreditGenInfoCustomerResponse[]) serviceResponseTO.getValue(responseDto);
		} else {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getInfoCustomer isSuccess NO ");
			method.error(serviceResponseTO);
			services.managementExeption(nameServices, serviceResponseTO);
			return null;
		}

	}

	// @i_operacion = 'DI', @i_tipo = 'RE' --Informacion Direcciones de Domiciliaria
	public ReportLongIndCreditGenAddressCustomerResponse[] getAddressCustomer(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
		String requestDto = ConstantValue.RequestName.IN_REPORT_REQUEST;
		String responseDto = ConstantValue.ReturnName.REPORT_LONG_IND_CREDIT_GEN_ADDRESS_CUSTOMER_RESPONSE;
		String nameServices = ConstantValue.ServiceName.LONG_INDIVIDUAL_CREDIT_APPLICATION_ADDRESS;

		logger.logError("----->>> ServicesLongIndividualCreditApplication -> getAddressCustomer Inicio:" + nameServices + " idCliente:" + reportRequest.getCustomerId());

		ServiceRequestTO serviceRequestTO = services.getHeaderRequest(sessionId, nameServices);

		serviceRequestTO.addValue(requestDto, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getAddressCustomer isSuccess ");
			return (ReportLongIndCreditGenAddressCustomerResponse[]) serviceResponseTO.getValue(responseDto);
		} else {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getAddressCustomer isSuccess NO ");
			method.error(serviceResponseTO);
			services.managementExeption(nameServices, serviceResponseTO);
		}
		return null;
	}

	// @i_operacion = 'DI' @i_tipo = 'AE' --Informacion Direcciones de Negocio
	public ReportLongIndCreditGenBusinessCustomerResponse[] getBusinessCustomer(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
		String requestDto = ConstantValue.RequestName.IN_REPORT_REQUEST;
		String responseDto = ConstantValue.ReturnName.REPORT_LONG_IND_CREDIT_GEN_BUSINESS_CUSTOMER_RESPONSE;
		String nameServices = ConstantValue.ServiceName.LONG_INDIVIDUAL_CREDIT_APPLICATION_BUSINESS_CUSTOMER;

		logger.logError("----->>> ServicesLongIndividualCreditApplication -> getBusinessCustomer Inicio:" + nameServices + " idCliente:" + reportRequest.getCustomerId());

		ServiceRequestTO serviceRequestTO = services.getHeaderRequest(sessionId, nameServices);

		serviceRequestTO.addValue(requestDto, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getBusinessCustomer isSuccess ");
			return (ReportLongIndCreditGenBusinessCustomerResponse[]) serviceResponseTO.getValue(responseDto);
		} else {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getBusinessCustomer isSuccess NO ");
			method.error(serviceResponseTO);
			services.managementExeption(nameServices, serviceResponseTO);
		}
		return null;
	}

	// @i_operacion = 'RP' --Informacion de Referencias Personales del Cliente
	public ReportLongIndCreditGenReferensCustomerResponse[] getReferencesCustomer(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
		String requestDto = ConstantValue.RequestName.IN_REPORT_REQUEST;
		String responseDto = ConstantValue.ReturnName.REPORT_LONG_IND_CREDIT_GEN_REFERENS_CUSTOMER_RESPONSE;
		String nameServices = ConstantValue.ServiceName.LONG_INDIVIDUAL_CREDIT_APPLICATION_REFERENCE_CUSTOMER;

		logger.logError("----->>> ServicesLongIndividualCreditApplication -> getReferencesCustomer Inicio:" + nameServices + " idCliente:" + reportRequest.getCustomerId());

		ServiceRequestTO serviceRequestTO = services.getHeaderRequest(sessionId, nameServices);

		serviceRequestTO.addValue(requestDto, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getReferencesCustomer isSuccess ");
			return (ReportLongIndCreditGenReferensCustomerResponse[]) serviceResponseTO.getValue(responseDto);
		} else {
			logger.logError("----->>> ServicesLongIndividualCreditApplication -> getReferencesCustomer isSuccess NO ");
			method.error(serviceResponseTO);
			services.managementExeption(nameServices, serviceResponseTO);
		}
		return null;
	}
	/*
	 * // @i_operacion = 'RC' --Informacion de Relaciones del Cliente public ReportLongIndCreditGenRelationshipCustomerResponse[] getRelationShipCustomer(ReportRequest reportRequest, String sessionId, ICTSServiceIntegration serviceIntegration) {
	 * String requestDto = ConstantValue.RequestName.IN_REPORT_REQUEST; String responseDto = ConstantValue.ReturnName.REPORT_LONG_IND_CREDIT_GEN_RELATIONSHIP_CUSTOMER_RESPONSE; String nameServices =
	 * ConstantValue.ServiceName.LONG_INDIVIDUAL_CREDIT_APPLICATION;
	 * 
	 * logger.logError("----->>> ServicesLongIndividualCreditApplication -> getRelationShipCustomer Inicio:" + nameServices + " idCliente:" + reportRequest.getCustomerId());
	 * 
	 * ServiceRequestTO serviceRequestTO = services.getHeaderRequest(sessionId, nameServices);
	 * 
	 * serviceRequestTO.addValue(requestDto, reportRequest); ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
	 * 
	 * if (serviceResponseTO.isSuccess()) { logger.logError("----->>> ServicesLongIndividualCreditApplication -> getRelationShipCustomer isSuccess "); return (ReportLongIndCreditGenRelationshipCustomerResponse[])
	 * serviceResponseTO.getValue(responseDto); } else { logger.logError("----->>> ServicesLongIndividualCreditApplication -> getRelationShipCustomer isSuccess NO "); method.error(serviceResponseTO); services.managementExeption(nameServices,
	 * serviceResponseTO); } return null; }
	 */
}
