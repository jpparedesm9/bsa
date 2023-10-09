package com.cobiscorp.cobis.busin.customevents.services;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamRequest;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamResponse;

public class ConsultingClientTeamServices extends BaseEvent implements IServicesConsultingClientsPrints {

	public ConsultingClientTeamServices(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory.getLogger(ConsultingClientTeamServices.class);

	public static final String SERVICEID_REPORTSAFECONSULTINGCLIENTTEAM = "Sales.Cloud.ConsultingClientsTeams.ConsultingClients";
	public static final String CONSTANT_Q = "Q";
	public static final String IN_CONSULTINGCLIENTTEAMREQUEST = "inConsultingClientTeamRequest";
	public static final String RETURN_CONSULTINGCLIENTTEAMRESPONSE = "returnConsultingClientTeamResponse";

	public ConsultingClientTeamRequest requestDataDtoServices(String idProcess) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" ***** Starting services DTO");
		}
		ConsultingClientTeamRequest reportSafeRequest = new ConsultingClientTeamRequest();
		reportSafeRequest.setTypeOperation(CONSTANT_Q.charAt(0));
		reportSafeRequest.setIdProcess(idProcess);

		if (logger.isDebugEnabled()) {
			logger.logDebug(" ***** idProcess  " + reportSafeRequest.getIdProcess());
			logger.logDebug(" ***** TypeOperation  " + reportSafeRequest.getTypeOperation());
		}
		return reportSafeRequest;
	}

	/**
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param reportSafeRequest
	 * @param sessionId
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public ConsultingClientTeamResponse[] consultingClientOfteams(String idProcess,	ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) 
			logger.logDebug(" *****Starting of services of client for id process"+idProcess);
		if (idProcess != null && (!idProcess.isEmpty() || !idProcess.equals(""))) {
			ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
			serviceRequestApplicationTO.addValue(IN_CONSULTINGCLIENTTEAMREQUEST, requestDataDtoServices(idProcess));
			ServiceResponse serviceResponse = execute(serviceIntegration, logger,
					SERVICEID_REPORTSAFECONSULTINGCLIENTTEAM, serviceRequestApplicationTO);

			if (serviceResponse != null && serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
				if (logger.isDebugEnabled()) {
					logger.logDebug(" *****SUCCESS SERVICE consultingClientOfteams");
					validationResponse(serviceResponseItemsTO);
					logger.logDebug(" *****RESPONSE CLIENTSAFERESPONSE"
							+ (serviceResponseItemsTO.getValue(RETURN_CONSULTINGCLIENTTEAMRESPONSE)));
				}
				return (ConsultingClientTeamResponse[]) (serviceResponseItemsTO
						.getValue(RETURN_CONSULTINGCLIENTTEAMRESPONSE));
			} else {
				if (logger.isDebugEnabled())
					logger.logDebug(" *****-- FALL SERVICE QUERYCONSULTINGINFORMATIONHEADLINE");
				return new ConsultingClientTeamResponse[0];
			}
		} else {
			return new ConsultingClientTeamResponse[0];
		}
	}

	@SuppressWarnings("rawtypes")
	public static void validationResponse(ServiceResponseTO serviceResponseTo) {
		Map map =  serviceResponseTo.getData();
		Set set = map.keySet();
		Iterator iterator = set.iterator();
		logger.logDebug("[IF (iterator != null)]:[" + (iterator != null) + "]");
		if (iterator != null) {
			while (iterator.hasNext())
				logger.logDebug("[response]:[" + (iterator.next()) + "]");
		}
	}

}

interface IServicesConsultingClientsPrints {

	/**
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param reportSafeRequest
	 * @param sessionId
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public ConsultingClientTeamResponse[] consultingClientOfteams(String idProcess,
			ICTSServiceIntegration serviceIntegration);

}