package com.cobiscorp.cobis.assets.reports.service;

import java.util.ArrayList;
import java.util.Arrays;

import cobiscorp.ecobis.assets.cloud.dto.DataCreditAgreement;
import cobiscorp.ecobis.assets.cloud.dto.GeneralDataCurrency;
import cobiscorp.ecobis.assets.cloud.dto.GeneralDataMarket;
import cobiscorp.ecobis.assets.cloud.dto.GeneralDataResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryCreditStudyAddress;
import cobiscorp.ecobis.assets.cloud.dto.QueryCreditStudyClient;
import cobiscorp.ecobis.assets.cloud.dto.QueryCreditStudyMicroenterprise;
import cobiscorp.ecobis.assets.cloud.dto.QueryCreditStudyReference;
import cobiscorp.ecobis.assets.cloud.dto.QueryCreditStudyRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReportCreditAgreement;
import cobiscorp.ecobis.assets.cloud.dto.ReportCreditAgreementClient;
import cobiscorp.ecobis.assets.cloud.dto.ReportCreditAgreementRequest;
import cobiscorp.ecobis.assets.cloud.dto.SwornDeclarationCredit;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 * 
 */
public class CreditAgreementService extends BaseService {
	private static final ILogger logger = LogFactory
			.getLogger(CreditAgreementService.class);

	public static final Integer FORMAT_DATE = 101;
	public static final String FORNTEND = "S";

	/***
	 * Obtiene la informacion del contrato de apertura
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public DataCreditAgreement queryCreditAgreementAll(
			ReportCreditAgreementRequest reportCreditAgreementRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia queryCreditAgreementAll");
		}

		DataCreditAgreement dataCreditAgreement = new DataCreditAgreement();
		if (reportCreditAgreementRequest.getBank() == null) {
			return null;
		}

		// DATOS GENERALES PRESTAMO
		this.generalLoanData(reportCreditAgreementRequest, serviceIntegration,
				dataCreditAgreement);

		// ESTUDIO DE CREDITO
		if (dataCreditAgreement.getGeneralDataResponse() != null) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Estudio de Credito");
			}

			Integer tramit = dataCreditAgreement.getGeneralDataResponse()
					.getTransactId();
			Integer customer = dataCreditAgreement.getGeneralDataResponse()
					.getCustomerId();

			if (tramit != null) {
				QueryCreditStudyRequest queryCreditStudyRequest = new QueryCreditStudyRequest();
				queryCreditStudyRequest.setTransact(tramit);
				queryCreditStudyRequest.setEntity(customer);

				this.creditStudy(queryCreditStudyRequest, serviceIntegration,
						dataCreditAgreement);

				queryCreditStudyRequest.setBank(reportCreditAgreementRequest
						.getBank());

				// DECLARACION JURAMENTADA - BIENES
				this.swornStatement(queryCreditStudyRequest,
						serviceIntegration, dataCreditAgreement);
			}
		}

		// CONTRATO DE CREDITO
		this.creditAgreement(reportCreditAgreementRequest, serviceIntegration,
				dataCreditAgreement);

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza queryCreditAgreementAll");
		}
		return dataCreditAgreement;
	}

	@SuppressWarnings("unchecked")
	private void generalLoanData(
			ReportCreditAgreementRequest reportCreditAgreementRequest,
			ICTSServiceIntegration serviceIntegration,
			DataCreditAgreement dataCreditAgreement) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia generalLoanData");
		}

		try {

			LoanRequest loanRequest = new LoanRequest();
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_GENERAL_LOAN_DATA);
			loanRequest.setCode(reportCreditAgreementRequest.getBank());
			loanRequest.setOperation('Q');
			loanRequest.setDateFormat(FORMAT_DATE);

			serviceReportRequestTO.getData().put(
					ConstantValue.IN_GENERAL_LOAN_DATA_REQUEST, loanRequest);

			// EJECUCION SERVICIO
			ServiceResponseTO serviceResponseTo = serviceIntegration
					.getResponseFromCTS(serviceReportRequestTO);

			if (serviceResponseTo.isSuccess()) {
				// SE OBTIENE RESULTS SET
				GeneralDataResponse[] queryDataResponse = (GeneralDataResponse[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_DATA_RESPONSE));

				GeneralDataMarket[] queryDataMarket = (GeneralDataMarket[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_DATA_MARKET));

				GeneralDataCurrency[] queryDataCurrency = (GeneralDataCurrency[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_DATA_CURRENCY));

				dataCreditAgreement
						.setGeneralDataResponse(queryDataResponse[0]);
				dataCreditAgreement.setDataMarket(queryDataMarket[0]);
				dataCreditAgreement.setDataCurrency(queryDataCurrency[0]);

			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Error ejecucion servicio generalLoanData");
				}
				util.error(serviceResponseTo);
			}
		} catch (Exception ex) {
			logger.logError("Exception generalLoanData", ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza generalLoanData");
			}
		}
	}

	@SuppressWarnings("unchecked")
	private void creditStudy(QueryCreditStudyRequest queryCreditStudyRequest,
			ICTSServiceIntegration serviceIntegration,
			DataCreditAgreement dataCreditAgreement) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia creditStudy");
		}
		try {

			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_CREDIT_STUDY);
			queryCreditStudyRequest.setFrontEnd(FORNTEND);
			serviceReportRequestTO.getData().put(
					ConstantValue.IN_CREDIT_STUDY_REQUEST,
					queryCreditStudyRequest);

			// EJECUCION SERVICIO
			ServiceResponseTO serviceResponseTo = serviceIntegration
					.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				// OBTENER RESULT SET
				QueryCreditStudyClient queryCreditStudyClient = (QueryCreditStudyClient) (serviceResponseTo
						.getValue(ConstantValue.RETURN_CREDIT_STUDY_CLIENT));

				QueryCreditStudyAddress queryCreditStudyAddress = (QueryCreditStudyAddress) (serviceResponseTo
						.getValue(ConstantValue.RETURN_CREDIT_STUDY_ADDRESS));

				QueryCreditStudyMicroenterprise queryCreditStudyMicroenterprise = (QueryCreditStudyMicroenterprise) (serviceResponseTo
						.getValue(ConstantValue.RETURN_CREDIT_STUDY_MICROENTERPRISE));

				QueryCreditStudyReference[] queryCreditStudyReference = (QueryCreditStudyReference[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_CREDIT_STUDY_REFERENCE));

				dataCreditAgreement
						.setCreditStudyClient(queryCreditStudyClient);
				dataCreditAgreement
						.setCreditStudyAddress(queryCreditStudyAddress);
				dataCreditAgreement
						.setCreditStudyMicroenterprise(queryCreditStudyMicroenterprise);

				if (queryCreditStudyReference.length != 0) {
					dataCreditAgreement
							.setCreditStudyReference(queryCreditStudyReference[0]);
				}

			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Error ejecucion servicio creditStudy");
				}
				util.error(serviceResponseTo);
			}
		} catch (Exception ex) {
			logger.logError("Exception creditStudy", ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza creditStudy");
			}
		}
	}

	@SuppressWarnings("unchecked")
	private void swornStatement(
			QueryCreditStudyRequest queryCreditStudyRequest,
			ICTSServiceIntegration serviceIntegration,
			DataCreditAgreement dataCreditAgreement) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia swornStatement");
		}

		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SWORN_STATEMENT);
			queryCreditStudyRequest.setFrontEnd(FORNTEND);
			queryCreditStudyRequest.setTypeReport("DJU");
			serviceReportRequestTO.getData().put(
					ConstantValue.IN_CREDIT_SWORN_STATEMENT,
					queryCreditStudyRequest);
			int lengthResponse = 0;
			int iniInterval = 1;

			ArrayList<SwornDeclarationCredit> swornDeclarationResponse = new ArrayList<SwornDeclarationCredit>();

			// EJECUCION SERVICIO
			do {
				iniInterval += lengthResponse;
				queryCreditStudyRequest.setIniInterval(iniInterval);
				queryCreditStudyRequest.setFinInterval(iniInterval
						+ ConstantValue.SWORN_QUERY_LENGTH - 1);

				ServiceResponseTO serviceResponseTo = serviceIntegration
						.getResponseFromCTS(serviceReportRequestTO);
				if (serviceResponseTo.isSuccess()) {
					// SE OBTIENE RESULT SET
					SwornDeclarationCredit[] swornDeclarationCredit = (SwornDeclarationCredit[]) (serviceResponseTo
							.getValue(ConstantValue.RETURN_CREDIT_SWORN_STATEMENT));
					lengthResponse = swornDeclarationCredit.length;
					swornDeclarationResponse
							.addAll(new ArrayList<SwornDeclarationCredit>(
									Arrays.asList(swornDeclarationCredit)));
				} else {
					logger.logError("Error ejecucion servicio swornStatement");
					util.error(serviceResponseTo);
				}
			} while (lengthResponse >= ConstantValue.SWORN_QUERY_LENGTH);

			dataCreditAgreement
					.setSwornDeclarationCredit(swornDeclarationResponse);

		} catch (Exception ex) {
			logger.logError("Exception swornStatement", ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza swornStatement");
			}
		}
	}

	@SuppressWarnings("unchecked")
	private void creditAgreement(
			ReportCreditAgreementRequest reportCreditAgreementRequest,
			ICTSServiceIntegration serviceIntegration,
			DataCreditAgreement dataCreditAgreement) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia creditAgreement");
		}

		try {

			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_CREDIT_AGREEMENT);
			serviceReportRequestTO.getData().put(
					ConstantValue.IN_CREDIT_AGREEMENT_REQUEST,
					reportCreditAgreementRequest);

			// EJECUCION SERVICIO
			ServiceResponseTO serviceResponseTo = serviceIntegration
					.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				// SE OBTIENE RESULT SET
				ReportCreditAgreement[] reportCreditAgreement = (ReportCreditAgreement[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_CREDIT_AGREEMENT));

				ReportCreditAgreementClient[] reportCreditAgreementClient = (ReportCreditAgreementClient[]) (serviceResponseTo
						.getValue(ConstantValue.RETURN_CREDIT_AGREEMENT_CLIENT));

				for (int i=0;i<reportCreditAgreement.length;i++){
					if (logger.isDebugEnabled()) {
						logger.logDebug("reportCreditAgreement --> "+i+"-->"+reportCreditAgreement[i]);
					}
				}
				
				if (reportCreditAgreement != null) {
					dataCreditAgreement
					.setCreditAgreement(reportCreditAgreement[0]);	
				}											

				if (reportCreditAgreementClient != null) {
					dataCreditAgreement
							.setCreditAgreementClient(new ArrayList<ReportCreditAgreementClient>(
									Arrays.asList(reportCreditAgreementClient)));
				}

			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Error ejecucion servicio creditAgreement");
				}
				util.error(serviceResponseTo);
			}
		} catch (Exception ex) {
			logger.logError("Exception creditAgreement", ex);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza creditAgreement");
			}
		}
	}
}
