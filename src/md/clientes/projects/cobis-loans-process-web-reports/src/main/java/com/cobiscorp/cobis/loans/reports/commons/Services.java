package com.cobiscorp.cobis.loans.reports.commons;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.loans.reports.dto.FirmasDTO;
import com.cobiscorp.cobis.loans.reports.dto.TransactionContextReport;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.AdditionalDataGroupResponse;
import cobiscorp.ecobis.loangroup.dto.ConsentCertificateResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanInfResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.LoanGroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.loangroup.dto.ReportRequest;
import cobiscorp.ecobis.loangroup.dto.ReportResponse;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovatioHeaderResponse;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovatioResponse;
import cobiscorp.ecobis.loangroup.dto.SimulationCreditRenovationRequest;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerBussiness;
import cobiscorp.ecobis.loanprocess.dto.LoanCustomerResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanDataRequest;
import cobiscorp.ecobis.loanprocess.dto.LoanInfResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanInfoApplicationResponse;
import cobiscorp.ecobis.loanprocess.dto.LoanRequest;
import cobiscorp.ecobis.systemconfiguration.dto.CatalogResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import cobiscorp.ecobis.systemconfiguration.dto.TableRequest;

public class Services {
	private static final ILogger logger = LogFactory.getLogger(Services.class);
	private static Method method = new Method();

	public ServiceRequestTO getHeaderRequest(String sessionId, String serviceId) {
		ServiceRequest headerRequest = new ServiceRequest();
		headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
		serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
		serviceReportRequestTO.setSessionId(sessionId);
		serviceReportRequestTO.setServiceId(serviceId);
		return serviceReportRequestTO;
	}

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

	public CatalogResponse[] getItemsByTable(String sessionId, int mode, String table, String nextCode, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug(" *****-- INICIO SERVICIO SEARCH_CATALOG para la tabla: " + table);
		if (table != null) {
			logger.logDebug(" *****-- CODIGO != NULL");
			TableRequest dtoReq = new TableRequest();
			dtoReq.setMode(mode);
			dtoReq.setName(table);

			if (Validate.Strings.isNotNullOrEmpty(nextCode)) {
				dtoReq.setNextCode(nextCode);
			}

			ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.SERVICES_CATALOG);
			serviceRequestTO.addValue(ConstantValue.RequestName.IN_TABLE_REQUEST, dtoReq);
			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
			if (serviceResponseTO.isSuccess()) {
				logger.logDebug(" *****--  SUCCESS SERVICE SEARCH_CATALOG");
				CatalogResponse[] catalogResponses = (CatalogResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_CATALOG);
				return catalogResponses;
			} else {
				method.error(serviceResponseTO);
				return null;
			}
		} else {
			logger.logDebug(" *****-- CODIGO = NULL");
			return null;
		}
	}

	public CatalogResponse[] searchCatalog(String sessionId, int mode, String tableName, ICTSServiceIntegration serviceIntegration) {
		List<CatalogResponse> catalogResponseList = new ArrayList<CatalogResponse>();
		boolean hasValue = false;
		String nextValue = "";

		// Primera ejecucion
		CatalogResponse[] catalogResponseArray = this.getItemsByTable(sessionId, 0, tableName, null, serviceIntegration);
		if (catalogResponseArray != null) {
			for (CatalogResponse item : catalogResponseArray) {
				catalogResponseList.add(item);
			}
			hasValue = true;
		}
		// Siguientes ejecuciones
		while (catalogResponseArray != null && catalogResponseArray.length == 20) {
			nextValue = catalogResponseArray[catalogResponseArray.length - 1].getCode();
			catalogResponseArray = this.getItemsByTable(sessionId, 1, tableName, nextValue, serviceIntegration);
			if (catalogResponseArray != null) {
				for (CatalogResponse item : catalogResponseArray) {
					catalogResponseList.add(item);
				}
			}
		}
		if (hasValue) {
			return catalogResponseList.toArray(new CatalogResponse[catalogResponseList.size()]);
		}
		return null;
	}

	public CatalogResponse getCatalogByCode(String sessionId, String tableName, String code, ICTSServiceIntegration serviceIntegration) {
		if (code != null && !code.isEmpty()) {
			CatalogResponse[] catalogResponseList = this.searchCatalog(sessionId, ConstantValue.valueConstant.MODE_0, tableName, serviceIntegration);
			if (catalogResponseList != null && catalogResponseList.length > 0) {
				for (CatalogResponse catalogResponse : catalogResponseList) {
					String sCadenaSinBlancos = Functions.eliminateSpace(catalogResponse.getCode());
					if (code.equals(sCadenaSinBlancos)) {
						return catalogResponse;
					}
				}
			}
		}
		return null;
	}

	public ParameterResponse getParameter(int mode, String parameterNemonic, String productNemonic, ICTSServiceIntegration serviceIntegration, String sessionId) {
		logger.logDebug("Inicio Servicio -> getParameter:" + ConstantValue.ServiceName.PARAMETERMANAGEMENT);
		ParameterRequest parameterRequest = new ParameterRequest();
		parameterRequest.setMode(mode);
		parameterRequest.setParameterNemonic(parameterNemonic);
		parameterRequest.setProductNemonic(productNemonic);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.PARAMETERMANAGEMENT);

		serviceRequestTO.addValue(ConstantValue.RequestName.INPARAMETERREQUEST, parameterRequest);

		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			ParameterResponse parameterResponse = (ParameterResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_PARAMETER_RESPONSE);
			return parameterResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.PARAMETERMANAGEMENT, serviceResponseTO);
		}
		return null;
	}

	// Application-tramite
	public ReportResponse getInformationGroup(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getInformationGroup:" + ConstantValue.ServiceName.GROUP_ACCOUNT_HEADER);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GROUP_ACCOUNT_HEADER);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			ReportResponse reportResponse = (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
			return reportResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GROUP_ACCOUNT_HEADER, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse[] getCreditSummary(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getCreditSummary:" + ConstantValue.ServiceName.GROUP_ACCOUNT_SUMMARY);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GROUP_ACCOUNT_SUMMARY);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GROUP_ACCOUNT_SUMMARY, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse[] getPaymentPlan(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getPaymentPlan:" + ConstantValue.ServiceName.GROUP_ACCOUNT_PAYMENT);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GROUP_ACCOUNT_PAYMENT);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GROUP_ACCOUNT_PAYMENT, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse getClearanceSheetHeader(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getClearanceSheetHeader:" + ConstantValue.ServiceName.SETTLEMENT_SHEET_HEADER);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.SETTLEMENT_SHEET_HEADER);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			ReportResponse reportResponse = (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
			return reportResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.SETTLEMENT_SHEET_HEADER, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse[] getClearanceSheetDetail(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getClearanceSheetDetail:" + ConstantValue.ServiceName.SETTLEMENT_SHEET_DETAIL);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.SETTLEMENT_SHEET_DETAIL);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.SETTLEMENT_SHEET_HEADER, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse[] getAccountStatusConsolidatedDetail(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getAccountStatusConsolidatedDetail:" + ConstantValue.ServiceName.CONSOLIDATED_ACCOUNT_STATUS_DETAIL);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.CONSOLIDATED_ACCOUNT_STATUS_DETAIL);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.CONSOLIDATED_ACCOUNT_STATUS_DETAIL, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse getAccountStatusConsolidatedHeader(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getAccountStatusConsolidatedHeader:" + ConstantValue.ServiceName.CONSOLIDATED_ACCOUNT_STATUS_HEADER);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.CONSOLIDATED_ACCOUNT_STATUS_HEADER);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			ReportResponse reportResponse = (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
			return reportResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.CONSOLIDATED_ACCOUNT_STATUS_HEADER, serviceResponseTO);
		}
		return null;
	}

	// /Amrtizacion
	public ReportResponse[] getAmortizationTableDetail(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getAmortizationTableDetail:" + ConstantValue.ServiceName.AMORTIZATION_TABLE_DETAIL);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.AMORTIZATION_TABLE_DETAIL);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.AMORTIZATION_TABLE_DETAIL, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse getAmortizationTableHeader(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getAmortizationTableHeader:" + ConstantValue.ServiceName.AMORTIZATION_TABLE_HEADER);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.AMORTIZATION_TABLE_HEADER);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			ReportResponse reportResponse = (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
			return reportResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.AMORTIZATION_TABLE_HEADER, serviceResponseTO);
		}
		return null;
	}

	public ReportResponse getAmortizationTableOperationHeader(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getAmortizationTableOperationHeader:" + ConstantValue.ServiceName.AMORTIZATION_TABLE_OPER_HEADER);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.AMORTIZATION_TABLE_OPER_HEADER);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			ReportResponse reportResponse = (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
			return reportResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.AMORTIZATION_TABLE_OPER_HEADER, serviceResponseTO);
		}
		return null;
	}

	// ORden de Desembolso
	public ReportResponse getDisbursementOrderHeader(String sessionId, String bank, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getDisbursementOrderHeader:" + ConstantValue.ServiceName.DISBURSEMENT_ORDER_HEADER + "----NumBanco:" + bank);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.DISBURSEMENT_ORDER_HEADER);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			ReportResponse reportResponse = (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
			return reportResponse;
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.DISBURSEMENT_ORDER_HEADER, serviceResponseTO);
		}
		return null;
	}

	// ORden de Desembolso
	public ReportResponse[] getDisbursementOrderDetail(String sessionId, String bank, String option, int mode, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getDisbursementOrderDetail:" + ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL + "NumeroBanco:" + bank + "--Opcion:" + option);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setBank(bank);
		reportRequest.setOption(option);
		reportRequest.setMode(mode);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL, serviceResponseTO);
		}
		return null;
	}

	//
	public LoanInfoApplicationResponse[] getApplicationInfo(String sessionId, char operation, int application, int mode, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getApplicationInfo:" + ConstantValue.ServiceName.GET_INFO_APPLICATION + "application:" + application + "--mode:" + mode);
		LoanDataRequest reportRequest = new LoanDataRequest();
		reportRequest.setOperation(operation);
		reportRequest.setMode(mode);
		reportRequest.setIdApplication(application);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GET_INFO_APPLICATION);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_IND_LOAN_DATA_REQST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (LoanInfoApplicationResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_LOAN_INFO_APPLICATION);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GET_INFO_APPLICATION, serviceResponseTO);
		}
		return null;
	}

	public Map<String, Object> getGroupLoanInformation(String sessionId, String transact, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia Servicio -> LoanGroup.GroupLoanQuerys.LoanGroupQuery");
		}
		if (transact != null) {
			ReportRequest reportRequest = new ReportRequest();
			reportRequest.setTramite(Integer.valueOf(transact));
			Map<String, Object> finalResponse = new HashMap<String, Object>();

			ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.LOAN_GROUP_QUERY);
			serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
			ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
			if (logger.isDebugEnabled()) {
				logger.logDebug("respuesta servicio: " + serviceResponseTO.getData());
			}
			if (serviceResponseTO.isSuccess()) {
				finalResponse.put(ConstantValue.valueConstant.GROUP_INFORMATION, (LoanGroupResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_LOAN_GROUP_RESPONSE));
				finalResponse.put(ConstantValue.valueConstant.ADDITIONAL_GROUP_INFORMATION,
						(AdditionalDataGroupResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_ADDITIONAL_DATA_GROUP));
				return finalResponse;
			} else {
				method.error(serviceResponseTO);
				this.managementExeption(ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL, serviceResponseTO);
			}
		}
		return null;
	}

	public GroupResponse getGroupInformation(String sessionId, int group, ICTSServiceIntegration serviceIntegration) {
		logger.logInfo("Inicio Servicio -> getGroupInformation");
		GroupRequest groupRequest = new GroupRequest();
		groupRequest.setCode(group);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.SEARCH_GROUP);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_GROUP_REQUEST, groupRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			return (GroupResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_GROUP_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL, serviceResponseTO);
		}
		return null;
	}

	// Integrates
	public MemberResponse[] getGroupMembers(String sessionId, int group, int application, int mode, ICTSServiceIntegration serviceIntegration) {
		logger.logInfo("Inicio Servicio -> getGroupMembers");
		MemberRequest groupRequest = new MemberRequest();
		groupRequest.setGroupId(group);
		groupRequest.setMode(mode);
		groupRequest.setApplicationCode(application);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GROUP_MEMBERS);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_MEMBER_REQUEST, groupRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (logger.isDebugEnabled()) {
			logger.logDebug("ServiceResponseTO getGroupMembers: " + serviceResponseTO.getData());
		}
		if (serviceResponseTO.isSuccess()) {
			return (MemberResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_MEMBER_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL, serviceResponseTO);
		}
		return null;
	}

	public MemberResponse[] getLoanGroupAmounts(String sessionId, String applicationCode, ICTSServiceIntegration serviceIntegration) {
		logger.logInfo("Inicio Servicio -> getLoanGroupAmounts");
		MemberRequest groupRequest = new MemberRequest();
		groupRequest.setApplicationCode(Integer.valueOf(applicationCode));
		groupRequest.setMode(0);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.LOAN_MEMBERS_AMOUNT);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_MEMBER_REQUEST, groupRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (logger.isDebugEnabled()) {
			logger.logDebug("ServiceResponseTO getLoanGroupAmounts: " + serviceResponseTO.getData());
		}
		if (serviceResponseTO.isSuccess()) {
			return (MemberResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_MEMBER_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.DISBURSEMENT_ORDER_DETAIL, serviceResponseTO);
		}
		return null;
	}

	public GroupLoanInfResponse[] getRecurringChargeMembers(String sessionId, String applicationCode, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Services.getRecurringChargeMembers(..) --> applicationCode= " + applicationCode);
		}
		GroupLoanAmountRequest groupLoanAmountRequest = new GroupLoanAmountRequest();
		groupLoanAmountRequest.setSolicitude(Integer.valueOf(applicationCode));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.RECURRING_CHARGE_GROUP);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_GRP_LOAN_AMNT_REQST, groupLoanAmountRequest);

		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			return (GroupLoanInfResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_GRP_LOAN_INF_RESP);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.RECURRING_CHARGE_GROUP, serviceResponseTO);
		}
		return null;
	}

	public GroupLoanInfResponse[] getGroupCreditCover(String sessionId, String applicationCode, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getGroupCreditCover --> applicationCode= " + applicationCode);
		}
		GroupLoanAmountRequest groupLoanAmountRequest = new GroupLoanAmountRequest();
		groupLoanAmountRequest.setSolicitude(Integer.valueOf(applicationCode));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GROUP_CREDIT_VOCER);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_GRP_LOAN_AMNT_REQST, groupLoanAmountRequest);

		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			return (GroupLoanInfResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_GRP_LOAN_INF_RESP);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GROUP_CREDIT_VOCER, serviceResponseTO);
		}
		return null;
	}

	public GroupLoanInfResponse[] getSearchGroupCreditPaymentList(String sessionId, String applicationCode, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getSearchGroupCreditPaymentList --> applicationCode= " + applicationCode);
		}
		GroupLoanAmountRequest groupLoanAmountRequest = new GroupLoanAmountRequest();
		groupLoanAmountRequest.setSolicitude(Integer.valueOf(applicationCode));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GRP_CRDT_PAYMENTS_LIST);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_GRP_LOAN_AMNT_REQST, groupLoanAmountRequest);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getSearchGroupCreditPaymentList --> getResponseFromCTS ");
		}
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Servicios.getSearchGroupCreditPaymentList --> serviceResponseTO.isSuccess() ");
			}
			return (GroupLoanInfResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_GRP_LOAN_INF_RESP);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GRP_CRDT_PAYMENTS_LIST, serviceResponseTO);
		}
		return null;
	}

	public GroupLoanInfResponse[] getPromissoryNoteInf(String aSessionId, String aApplication, ICTSServiceIntegration aServiceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Services.getPromissoryNoteInf(..) --> aApplication= " + aApplication);
		}
		GroupLoanAmountRequest loanRequest = new GroupLoanAmountRequest();
		loanRequest.setSolicitude(Integer.valueOf(aApplication));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(aSessionId, ConstantValue.ServiceName.GRP_PROMISSORY_NOTE);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_GRP_LOAN_AMNT_REQST, loanRequest);

		ServiceResponseTO serviceResponseTO = aServiceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			return (GroupLoanInfResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_GRP_LOAN_INF_RESP);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GRP_PROMISSORY_NOTE, serviceResponseTO);
		}
		return null;
	}

	public LoanInfResponse[] getCreditContractCover(String aSessionId, String aApplication, ICTSServiceIntegration aServiceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getCreditContractCover --> applicationCode= " + aApplication);
		}
		LoanRequest wLoanAmountRequest = new LoanRequest();
		wLoanAmountRequest.setSolicitude(Integer.valueOf(aApplication));

		ServiceRequestTO wServiceRequestTO = this.getHeaderRequest(aSessionId, ConstantValue.ServiceName.INDIVIDUAL_CREDIT_VOCER);
		wServiceRequestTO.addValue(ConstantValue.RequestName.IN_IND_LOAN_AMNT_REQST, wLoanAmountRequest);

		ServiceResponseTO wServiceResponseTO = aServiceIntegration.getResponseFromCTS(wServiceRequestTO);
		if (wServiceResponseTO.isSuccess()) {
			return (LoanInfResponse[]) wServiceResponseTO.getValue(ConstantValue.ReturnName.RETURN_IND_LOAN_INF_RESP);
		} else {
			method.error(wServiceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.INDIVIDUAL_CREDIT_VOCER, wServiceResponseTO);
		}
		return null;
	}

	public LoanInfResponse[] getSearchCreditPaymentList(String aSessionId, String aApplication, ICTSServiceIntegration aServiceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getSearchCreditPaymentList --> applicationCode= " + aApplication);
		}
		LoanRequest wLoanAmountRequest = new LoanRequest();
		wLoanAmountRequest.setSolicitude(Integer.valueOf(aApplication));

		ServiceRequestTO wServiceRequestTO = this.getHeaderRequest(aSessionId, ConstantValue.ServiceName.IND_CRDT_PAYMENTS_LIST);
		wServiceRequestTO.addValue(ConstantValue.RequestName.IN_IND_LOAN_AMNT_REQST, wLoanAmountRequest);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getSearchCreditPaymentList --> getResponseFromCTS ");
		}
		ServiceResponseTO wServiceResponseTO = aServiceIntegration.getResponseFromCTS(wServiceRequestTO);
		if (wServiceResponseTO.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Servicios.getSearchCreditPaymentList --> serviceResponseTO.isSuccess() ");
			}
			return (LoanInfResponse[]) wServiceResponseTO.getValue(ConstantValue.ReturnName.RETURN_IND_LOAN_INF_RESP);
		} else {
			method.error(wServiceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.IND_CRDT_PAYMENTS_LIST, wServiceResponseTO);
		}
		return null;
	}

	public Map<String, Object> getCustomerData(String aSessionId, String aApplication, String aDebtorType, ICTSServiceIntegration aServiceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getCustomerData --> applicationCode= " + aApplication);
		}
		Map<String, Object> wFinalResponse = new HashMap<String, Object>();
		LoanDataRequest wLoanDataRequest = new LoanDataRequest();
		wLoanDataRequest.setIdApplication(Integer.valueOf(aApplication));
		if (aDebtorType != null) {
			wLoanDataRequest.setDebtorType(aDebtorType);
		}

		ServiceRequestTO wServiceRequestTO = this.getHeaderRequest(aSessionId, ConstantValue.ServiceName.GET_CUSTOMER_DATA);
		wServiceRequestTO.addValue(ConstantValue.RequestName.IN_IND_LOAN_DATA_REQST, wLoanDataRequest);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Servicios.getCustomerData --> getResponseFromCTS ");
		}
		ServiceResponseTO wServiceResponseTO = aServiceIntegration.getResponseFromCTS(wServiceRequestTO);
		if (wServiceResponseTO.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Servicios.getCustomerData --> serviceResponseTO.isSuccess() ");
			}
			wFinalResponse.put(ConstantValue.valueConstant.CUSTOMER_INFORMATION, (LoanCustomerResponse[]) wServiceResponseTO.getValue(ConstantValue.ReturnName.RETURN_LOAN_CUST_RESP));
			wFinalResponse.put(ConstantValue.valueConstant.ADD_CUSTOMER_INFORMATION, (LoanCustomerBussiness[]) wServiceResponseTO.getValue(ConstantValue.ReturnName.RETURN_LOAN_CUST_BUSS_RESP));
			return wFinalResponse;
		} else {
			method.error(wServiceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GET_CUSTOMER_DATA, wServiceResponseTO);
		}
		return null;
	}

	public LoanInfResponse[] getLoanRecurringCharge(String aSessionId, String aApplication, ICTSServiceIntegration wServiceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Services.getLoanRecurringCharge(..) --> applicationCode= " + aApplication);
		}
		LoanRequest wLoanRequest = new LoanRequest();
		wLoanRequest.setSolicitude(Integer.valueOf(aApplication));

		ServiceRequestTO wServiceRequestTO = this.getHeaderRequest(aSessionId, ConstantValue.ServiceName.LOAN_REC_CHARGE);
		wServiceRequestTO.addValue(ConstantValue.RequestName.IN_IND_LOAN_AMNT_REQST, wLoanRequest);

		ServiceResponseTO wServiceResponseTO = wServiceIntegration.getResponseFromCTS(wServiceRequestTO);
		if (wServiceResponseTO.isSuccess()) {
			return (LoanInfResponse[]) wServiceResponseTO.getValue(ConstantValue.ReturnName.RETURN_IND_LOAN_INF_RESP);
		} else {
			method.error(wServiceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.LOAN_REC_CHARGE, wServiceResponseTO);
		}
		return null;
	}

	public SimulationCreditRenovatioResponse[] getSimulationRenovationData(String sessionId, String monto, String plazo, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Services.getSimulationRenovationData");
		}
		SimulationCreditRenovationRequest simulationRequest = new SimulationCreditRenovationRequest();
		simulationRequest.setMonto(Double.parseDouble(monto));
		simulationRequest.setPlazo(Integer.parseInt(plazo));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.SERVICEID_GENERATE_SIMULATE_TABLE);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_SIMULATION_GENERATE, simulationRequest);

		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			return (SimulationCreditRenovatioResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_IND_SIMULATION_RESP);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.SERVICEID_GENERATE_SIMULATE_TABLE, serviceResponseTO);
		}
		return null;
	}

	public SimulationCreditRenovatioHeaderResponse[] getSimulationRenovationDataHeader(String sessionId, String monto, String plazo, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Services.getSimulationRenovationDataHeader");
		}
		SimulationCreditRenovationRequest simulationRequest = new SimulationCreditRenovationRequest();
		simulationRequest.setMonto(Double.parseDouble(monto));
		simulationRequest.setPlazo(Integer.parseInt(plazo));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.SERVICEID_GENERATE_SIMULATE_TABLE);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_SIMULATION_GENERATE, simulationRequest);

		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			return (SimulationCreditRenovatioHeaderResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_IND_SIMULATION_RESP_HEAD);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.SERVICEID_GENERATE_SIMULATE_TABLE, serviceResponseTO);
		}
		return null;
	}

	public LoanInfResponse getLoanData(String sessionId, String applicationCode, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Services.getLoanData(..) --> applicationCode= " + applicationCode);
		}
		LoanDataRequest loanRequest = new LoanDataRequest();
		loanRequest.setIdApplication(Integer.valueOf(applicationCode));

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GET_LOAN_DATA);
		serviceRequestTO.addValue(ConstantValue.RequestName.IN_IND_LOAN_DATA_REQST, loanRequest);

		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);
		if (serviceResponseTO.isSuccess()) {
			return (LoanInfResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_IND_LOAN_INF_RESP);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.LOAN_REC_CHARGE, serviceResponseTO);
		}
		return null;
	}

	// pagare
	public ReportResponse getPayment(String sessionId, ReportRequest reportRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("Inicio Servicio -> getPayment:" + ConstantValue.ServiceName.PAYMENT_DETAIL);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.PAYMENT_DETAIL);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logDebug("Inicio Servicio -> getPayment Return:" + serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE));
			return (ReportResponse) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.PAYMENT_DETAIL, serviceResponseTO);
		}
		return null;
	}

	// kyc
	public ReportResponse[] getKYCSimplificado(Integer applicationId, String sessionId, ICTSServiceIntegration serviceIntegration) {
		logger.logError("Inicio Servicio -> getKYCSimplificado:" + ConstantValue.ServiceName.GET_KYCSimplificado + " idTramite:" + applicationId);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setTramite(applicationId);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GET_KYCSimplificado);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logError("Servicio -> getKYCSimplificado isSuccess ");
			return (ReportResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_REPORT_RESPONSE);
		} else {
			logger.logError("Servicio -> getKYCSimplificado isSuccess NO ");
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GET_KYCSimplificado, serviceResponseTO);
		}
		return null;
	}

	public TransactionContextReport dataListFirm(List<FirmasDTO> dataListFirma) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****-- INICIO SERVICIO dataListFirma -- dataListFirma:" + dataListFirma);
		}

		List<FirmasDTO> dataListFirma1 = new ArrayList<FirmasDTO>();
		List<FirmasDTO> dataListFirma2 = new ArrayList<FirmasDTO>();

		if (dataListFirma != null && !dataListFirma.isEmpty()) {
			for (int i = 0; i < dataListFirma.size(); i++) {
				if ((i % 2) == 0) {
					FirmasDTO dataListFirma11 = new FirmasDTO();
					dataListFirma11.setCargo(dataListFirma.get(i).getCargo());
					dataListFirma11.setNombre(dataListFirma.get(i).getNombre());
					dataListFirma1.add(dataListFirma11);
				} else {
					FirmasDTO dataListFirma22 = new FirmasDTO();
					dataListFirma22.setCargo(dataListFirma.get(i).getCargo());
					dataListFirma22.setNombre(dataListFirma.get(i).getNombre());
					dataListFirma2.add(dataListFirma22);
				}
			}
		}
		TransactionContextReport listFirm = new TransactionContextReport();
		listFirm.addValue(ConstantValue.valueConstant.list1, dataListFirma1);
		listFirm.addValue(ConstantValue.valueConstant.list2, dataListFirma2);

		return listFirm;
	}

	// Certificado de Consentimiento
	public ConsentCertificateResponse[] getCertificado(Integer applicationId, String reportNemonic, String operation, String sessionId, ICTSServiceIntegration serviceIntegration) {
		logger.logError("Inicio Servicio -> getCertificado:" + ConstantValue.ServiceName.GET_CERTIFICADO + " idTramite:" + applicationId);
		ReportRequest reportRequest = new ReportRequest();
		reportRequest.setTramite(applicationId);
		reportRequest.setReportNemonic(reportNemonic);
		reportRequest.setOperation(operation);

		ServiceRequestTO serviceRequestTO = this.getHeaderRequest(sessionId, ConstantValue.ServiceName.GET_CERTIFICADO);

		serviceRequestTO.addValue(ConstantValue.RequestName.IN_REPORT_REQUEST, reportRequest);
		ServiceResponseTO serviceResponseTO = serviceIntegration.getResponseFromCTS(serviceRequestTO);

		if (serviceResponseTO.isSuccess()) {
			logger.logError("Servicio -> getCertificado isSuccess ");
			return (ConsentCertificateResponse[]) serviceResponseTO.getValue(ConstantValue.ReturnName.RETURN_CERTIFICATE_RESPONSE);
		} else {
			logger.logError("Servicio -> getCertificado isSuccess NO ");
			method.error(serviceResponseTO);
			this.managementExeption(ConstantValue.ServiceName.GET_CERTIFICADO, serviceResponseTO);
		}
		return null;
	}

}
