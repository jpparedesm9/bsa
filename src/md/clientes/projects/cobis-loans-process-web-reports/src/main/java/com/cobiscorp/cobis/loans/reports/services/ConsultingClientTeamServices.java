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
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamRequest;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamResponse;

@SuppressWarnings({ "unchecked", "rawtypes" })
public class ConsultingClientTeamServices implements IServicesConsultingClients {
	private static final ILogger logger = LogFactory.getLogger(ConsultingClientTeamServices.class);

	/**
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param reportSafeRequest
	 * @param sessionId
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public ConsultingClientTeamResponse[] consultingClientOfteams(String idProcess, String sessionId,
			ICTSServiceIntegration serviceIntegration) {
		Method method = new Method();
		Services services = new Services();
		String nameServices = ServiceName.SERVICEID_REPORTSAFECONSULTINGCLIENTTEAM;
		logger.logError("----->>> ConsultingClientTeamServices -> consultingClientOfteams starting...:" + nameServices
				+ " idClientes:" + idProcess);

		if (idProcess != null && (!idProcess.isEmpty() || !idProcess.equals(""))) {
			ServiceRequestTO serviceReportRequestTO = services.getHeaderRequest(sessionId, nameServices);
			
			ConsultingClientTeamRequest reportSafeRequest = new ConsultingClientTeamRequest();
			reportSafeRequest.setTypeOperation(ConstantValue.valueConstant.CONSTANT_Q.charAt(0));
			reportSafeRequest.setIdProcess(idProcess);

			if (logger.isDebugEnabled()) {
				logger.logDebug(" ***** idProcess  " + reportSafeRequest.getIdProcess());
				logger.logDebug(" ***** TypeOperation  " + reportSafeRequest.getTypeOperation());
			}

			serviceReportRequestTO.getData().put(ConstantValue.RequestName.IN_CONSULTINGCLIENTTEAMREQUEST, reportSafeRequest);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE consultingClientOfteams");
					validationResponse(serviceResponseTo);
					logger.logDebug(" *****RESPONSE RETURN_CONSULTINGCLIENTTEAMRESPONSE"
							+ (serviceResponseTo.getValue(ConstantValue.ReturnName.RETURN_CONSULTINGCLIENTTEAMRESPONSE)));
				}

				return (ConsultingClientTeamResponse[]) (serviceResponseTo
						.getValue(ConstantValue.ReturnName.RETURN_CONSULTINGCLIENTTEAMRESPONSE));

			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE QUERYCONSULTINGINFORMATIONHEADLINE");
				method.error(serviceResponseTo);
				return new ConsultingClientTeamResponse[0];
			}
		} else {
			return new ConsultingClientTeamResponse[0];
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

interface IServicesConsultingClients {

	/***
	 * 
	 * @param idProcess
	 * @param sessionId
	 * @param serviceIntegration
	 * @return
	 */
	ConsultingClientTeamResponse[] consultingClientOfteams(String idProcess, String sessionId,
			ICTSServiceIntegration serviceIntegration);

}