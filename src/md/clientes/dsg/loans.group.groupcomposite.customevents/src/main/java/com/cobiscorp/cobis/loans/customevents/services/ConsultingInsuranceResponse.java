package com.cobiscorp.cobis.loans.customevents.services;

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
import cobiscorp.ecobis.loansbusiness.dto.InsuranceResponse;

public class ConsultingInsuranceResponse extends BaseEvent implements IServicesConsultingInsurance {

	public ConsultingInsuranceResponse(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory.getLogger(ConsultingInsuranceResponse.class);

	public static final String SERVICEID_REPORTSAFECONSULTINGINSURANCE = "LoansBusiness.Insurance.QueryInsurance";
	public static final String RETURN_CONSULTINGINSURANCE = "returnInsuranceResponse";

	/**
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param reportSafeRequest
	 * @param sessionId
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public InsuranceResponse[] consultingInsurance(ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled())
			;

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();

		ServiceResponse serviceResponse = execute(serviceIntegration, logger, SERVICEID_REPORTSAFECONSULTINGINSURANCE, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			if (logger.isDebugEnabled()) {
				validationResponse(serviceResponseItemsTO);
				logger.logDebug(" *****SUCCESS SERVICE consultingInsurance");
				logger.logDebug(" *****RESPONSE INSURANCERESPONSE" + (serviceResponseItemsTO.getValue(RETURN_CONSULTINGINSURANCE)));
			}
			return (InsuranceResponse[]) (serviceResponseItemsTO.getValue(RETURN_CONSULTINGINSURANCE));
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug(" *****-- FALL SERVICE QUERYCONSULTINGINSURANCERESPONSE");
			return new InsuranceResponse[0];
		}

	}

	@SuppressWarnings("rawtypes")
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

interface IServicesConsultingInsurance {

	/**
	 * get consulting of informationHeadLine operation I
	 * 
	 * @param reportSafeRequest
	 * @param sessionId
	 * @param serviceIntegration
	 * @return ClientSafeResponse
	 */
	public InsuranceResponse[] consultingInsurance(ICTSServiceIntegration serviceIntegration);

}