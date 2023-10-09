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

@SuppressWarnings({ "unchecked", "rawtypes" })
public class SecureConsentService implements ServicesExecute {
	private static final ILogger logger = LogFactory.getLogger(SecureConsentService.class);

	/**
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param reportSafeRequest
	 * @param sessionId
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public ClientSafeResponse[] queryInformationHeadLine(String codeclient, String procedureNumber, String operation, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFEINFORMATION;
		logger.logError("----->>> SecureConsentService -> queryInformationHeadLine starting...:" + nameServices + " idClientes:" + codeclient);

		if (codeclient != null && (!codeclient.isEmpty() || !codeclient.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportSafeRequest reportSafeRequest = new ReportSafeRequest();
			reportSafeRequest.setTypeOperation(operation.charAt(0));//ConstantValue.valueConstant.CONSTANT_I.charAt(0));
			reportSafeRequest.setIdentificationClient(codeclient);
			reportSafeRequest.setProcedureNumber(procedureNumber);

			if (logger.isDebugEnabled()) {
				logger.logDebug(" ***** IdentificationClient  " + reportSafeRequest.getIdentificationClient());
				logger.logDebug(" ***** TypeOperation  " + reportSafeRequest.getTypeOperation());
			}

			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTSAFEREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE QUERYCONSULTINGINFORMATIONHEADLINE");
					validationResponse(serviceResponseTo);
					logger.logDebug(" *****RESPONSE CLIENTSAFERESPONSE" + (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFERESPONSE)));
				}

				return (ClientSafeResponse[]) (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFERESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE QUERYCONSULTINGINFORMATIONHEADLINE");
				method.error(serviceResponseTo);
				return new ClientSafeResponse[0];
			}
		} else {
			return new ClientSafeResponse[0];
		}
	}

	/***
	 * get declaration of benefits queryConsultinginDeclareBenefits
	 * 
	 * @param reportSafeRequest
	 * @param serviceIntegration
	 * @return ClientSafeBenefitsResponse
	 */

	public ClientSafeBenefitsResponse[] queryConsultinginDeclareBenefits(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFEBENEFITS;
		logger.logError("----->>> SecureConsentService -> queryConsultinginDeclareBenefits starting...:" + nameServices + " idCliente:" + codeclient);

		if (codeclient != null && (!codeclient.isEmpty() || !codeclient.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportSafeRequest reportSafeRequest = new ReportSafeRequest();
			reportSafeRequest.setTypeOperation(ConstantValue.valueConstant.CONSTANT_B.charAt(0));
			reportSafeRequest.setIdentificationClient(codeclient);

			if (logger.isDebugEnabled()) {
				logger.logDebug(" ***** IdentificationClient  " + reportSafeRequest.getIdentificationClient());
				logger.logDebug(" ***** TypeOperation  " + reportSafeRequest.getTypeOperation());
			}
			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTSAFEREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE QUERYCONSULTINGINDECLAREBENEFITS");
					validationResponse(serviceResponseTo);
					logger.logDebug(" *****RESPONSE CLIENTSAFEBENEFITSRESPONSE" + (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFEBENEFITSRESPONSE)));
				}

				return (ClientSafeBenefitsResponse[]) (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTSAFEBENEFITSRESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE QUERYCONSULTINGINDECLAREBENEFITS");
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
	public ClientInformationBenefisResponse[] queryConsultinginSecureBenefits(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFEDECLARATION;
		logger.logError("----->>> SecureConsentService -> queryConsultinginSecureBenefits starting...:" + nameServices + " idCliente:" + codeclient);

		if (codeclient != null && (!codeclient.isEmpty() || !codeclient.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			ReportSafeRequest reportSafeRequest = new ReportSafeRequest();
			reportSafeRequest.setTypeOperation(ConstantValue.valueConstant.CONSTANT_S.charAt(0));
			reportSafeRequest.setIdentificationClient(codeclient);

			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_REPORTSAFEREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE QUERYCONSULTINGINSECUREBENEFITS");
					validationResponse(serviceResponseTo);
					logger.logDebug(
							" *****RESPONSE CLIENTINFORMATIONBENEFISRESPONSE" + (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTINFORMATIONBENEFISRESPONSE)));
				}

				return (ClientInformationBenefisResponse[]) (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CLIENTINFORMATIONBENEFISRESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE QUERYCONSULTINGINSECUREBENEFITS");
				method.error(serviceResponseTo);
				return new ClientInformationBenefisResponse[0];
			}
		} else {
			return new ClientInformationBenefisResponse[0];
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

interface ServicesExecute {
	/***
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientSafeResponse[]
	 */
	ClientSafeResponse[] queryInformationHeadLine(String codeclient, String procedureNumber,String operation, String sessionId, ICTSServiceIntegration serviceIntegration);

	/***
	 * get declaration of benefits queryConsultinginDeclareBenefits B
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientSafeBenefitsResponse[]
	 */
	ClientSafeBenefitsResponse[] queryConsultinginDeclareBenefits(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration);

	/**
	 * query Consulting in Secure Benefits table S
	 * 
	 * @param codeclient
	 * @param serviceIntegration
	 * @return ClientInformationBenefisResponse[]
	 */
	ClientInformationBenefisResponse[] queryConsultinginSecureBenefits(String codeclient, String sessionId, ICTSServiceIntegration serviceIntegration);
}