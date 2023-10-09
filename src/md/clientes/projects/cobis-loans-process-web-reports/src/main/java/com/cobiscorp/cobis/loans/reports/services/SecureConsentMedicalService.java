package com.cobiscorp.cobis.loans.reports.services;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue;
import com.cobiscorp.cobis.loans.reports.commons.ConstantValue.ServiceName;
import com.cobiscorp.cobis.loans.reports.commons.Method;
import com.cobiscorp.cobis.loans.reports.commons.Services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ClientInformationBenefisResponse;
import cobiscorp.ecobis.sales.cloud.dto.ClientSafeBenefitsResponse;
import cobiscorp.ecobis.sales.cloud.dto.ClientSafeResponse;
import cobiscorp.ecobis.sales.cloud.dto.ReportSafeRequest;
import cobiscorp.ecobis.sales.cloud.dto.ReportZurichInformationRequest;
import cobiscorp.ecobis.sales.cloud.dto.ReportZurichInformationResponse;


@SuppressWarnings({ "unchecked", "rawtypes" })
public class SecureConsentMedicalService implements ServicesExecuteMedical {
	private static final ILogger logger = LogFactory.getLogger(SecureConsentMedicalService.class);

	private static final String CLASSEXEUTE = "SecureConsentMedicalService>>>";

	/**
	 * get consulting of informationHeadLine operation I report medical
	 * 
	 * @param reportSafeRequest
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public ClientSafeResponse[] queryHeadLineMedical(String codeclient, String procedureNumber, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFEINFORMATION_MEDICAL;
		logger.logError(CLASSEXEUTE + "----->>> SecureConsentMedicalService -> queryHeadLineMedical starting...:" + nameServices + " idClientess:" + codeclient);

		if (codeclient != null && (!codeclient.isEmpty() || !codeclient.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportSafeRequest reportSafeRequest = new ReportSafeRequest();
			reportSafeRequest.setTypeOperation(ConstantValue.valueConstant.CONSTANT_I.charAt(0));
			reportSafeRequest.setIdentificationClient(codeclient);
			reportSafeRequest.setProcedureNumber(procedureNumber);

			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASSEXEUTE + " ***** MEDICAL IdentificationClient  " + reportSafeRequest.getIdentificationClient());
				logger.logDebug(CLASSEXEUTE + " ***** MEDICAL TypeOperation  " + reportSafeRequest.getTypeOperation());
			}

			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTSAFEREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(CLASSEXEUTE + " *****SUCCESS SERVICE QUERYCONSULTINGINFORMATIONHEADLINE MEDICAL");
					logger.logDebug(CLASSEXEUTE + " *****RESPONSE CLIENTSAFERESPONSE MEDICAL" + (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFERESPONSE)));
				}

				return (ClientSafeResponse[]) (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFERESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(CLASSEXEUTE + " *****-- FALL SERVICE  QUERYCONSULTINGINFORMATIONHEADLINE MEDICAL");
				method.error(serviceResponseTo);
				return new ClientSafeResponse[0];
			}
		} else {
			return new ClientSafeResponse[0];
		}
	}

	/***
	 * get declaration of benefits queryConsultinginDeclareBenefits B report medical
	 * 
	 * @param reportSafeRequest
	 * @param serviceIntegration
	 * @return ClientSafeBenefitsResponse
	 */

	public ClientSafeBenefitsResponse[] queryDeclareBenefitsMedical(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFEBENEFITS_MEDICAL;
		logger.logError(CLASSEXEUTE + "----->>> SecureConsentMedicalService -> queryDeclareBenefitsMedical starting...:" + nameServices + " idClientes:" + codeclient);

		if (codeclient != null && (!codeclient.isEmpty() || !codeclient.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportSafeRequest reportSafeRequest = new ReportSafeRequest();
			reportSafeRequest.setTypeOperation(ConstantValue.valueConstant.CONSTANT_B.charAt(0));
			reportSafeRequest.setIdentificationClient(codeclient);

			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASSEXEUTE + " ***** MEDICAL IdentificationClient  " + reportSafeRequest.getIdentificationClient());
				logger.logDebug(CLASSEXEUTE + " ***** MEDICAL TypeOperation  " + reportSafeRequest.getTypeOperation());
			}
			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTSAFEREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(CLASSEXEUTE + " *****SUCCESS SERVICE QUERYCONSULTINGINDECLAREBENEFITS MEDICAL");
					validationResponse(serviceResponseTo);
					logger.logDebug(CLASSEXEUTE + " *****RESPONSE CLIENTSAFEBENEFITSRESPONSE MEDICAL"
							+ (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFEBENEFITSRESPONSE)));
				}

				return (ClientSafeBenefitsResponse[]) (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFEBENEFITSRESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(CLASSEXEUTE + " *****-- FALL SERVICE QUERYCONSULTINGINDECLAREBENEFITS MEDICAL");
				method.error(serviceResponseTo);
				return new ClientSafeBenefitsResponse[0];
			}
		} else {
			return new ClientSafeBenefitsResponse[0];
		}
	}

	/***
	 * query Consulting in Secure Benefits table
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientInformationBenefisResponse[]
	 */
	public ClientInformationBenefisResponse[] querySecureBenefitsMedical(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFEDECLARATION_MEDICAL;
		logger.logError(CLASSEXEUTE + "----->>> SecureConsentMedicalService -> queryDeclareBenefitsMedical starting...:" + nameServices + " idClientes:" + codeclient);

		if (codeclient != null && (!codeclient.isEmpty() || !codeclient.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportSafeRequest reportSafeRequest = new ReportSafeRequest();
			reportSafeRequest.setTypeOperation(ConstantValue.valueConstant.CONSTANT_S.charAt(0));
			reportSafeRequest.setIdentificationClient(codeclient);

			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTSAFEREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(CLASSEXEUTE + " *****SUCCESS  SERVICE QUERYCONSULTINGINSECUREBENEFITS MEDICAL");
					validationResponse(serviceResponseTo);
					logger.logDebug(" *****RESPONSE CLIENTINFORMATIONBENEFISRESPONSE MEDICAL "
							+ (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTINFORMATIONBENEFISRESPONSE)));
				}

				return (ClientInformationBenefisResponse[]) (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTINFORMATIONBENEFISRESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(CLASSEXEUTE + " *****-- FALL SERVICE QUERYCONSULTINGINSECUREBENEFITS MEDICAL");
				method.error(serviceResponseTo);
				return new ClientInformationBenefisResponse[0];
			}
		} else {
			return new ClientInformationBenefisResponse[0];
		}
	}
	
	public ReportZurichInformationResponse[] reportZurichInformation(String client, int operationId, String operation, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTZURICH_INFORMATION;
		logger.logError(CLASSEXEUTE+"----->>> SecureConsentMedicalService -> reportZurichInformation starting...:" + nameServices	+ " operationId:" + operationId);
		if (operationId > 0) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportZurichInformationRequest request = new ReportZurichInformationRequest();
			request.setCliente(client);
			request.setOperacion(operation);
			request.setTramite(operationId);
			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTZURICHINFORMATIONREQUEST, request);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(CLASSEXEUTE+" *****SUCCESS  SERVICE reportZurichInformation");
					validationResponse(serviceResponseTo);
					logger.logDebug(" *****RESPONSE ReportZurichInformationRequest "
							+ (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_REPORTZURICHINFORMATIONRESPONSE)));
				}
				return (ReportZurichInformationResponse[]) (serviceResponseTo
						.getValue(ConstantValue.ReturnName.RETURN_REPORTZURICHINFORMATIONRESPONSE));
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(CLASSEXEUTE+" *****-- FALL SERVICE reportZurichInformation");
				method.error(serviceResponseTo);
				return new ReportZurichInformationResponse[0];
			}
		} else {
			return new ReportZurichInformationResponse[0];
		}
	}

	public static void validationResponse(ServiceResponseTO serviceResponseTo) {
		Map map = serviceResponseTo.getData();
		Set set = map.keySet();
		Iterator iterator = set.iterator();
		logger.logDebug("[IF (iterator != null)]:[" + (iterator != null) + "]");
		if (iterator != null) {
			while (iterator.hasNext())
				logger.logDebug("[response]:[" + (iterator.next()) + "]");
		}
	}

}

interface ServicesExecuteMedical {
	/***
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientSafeResponse[]
	 */
	ClientSafeResponse[] queryHeadLineMedical(String codeclient, String procedureNumber, String sessionId, ICTSServiceIntegration serviceIntegration);

	/***
	 * get declaration of benefits queryConsultinginDeclareBenefits B
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientSafeBenefitsResponse[]
	 */
	ClientSafeBenefitsResponse[] queryDeclareBenefitsMedical(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration);

	/**
	 * query Consulting in Secure Benefits table S
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientInformationBenefisResponse[]
	 */
	ClientInformationBenefisResponse[] querySecureBenefitsMedical(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration);
}