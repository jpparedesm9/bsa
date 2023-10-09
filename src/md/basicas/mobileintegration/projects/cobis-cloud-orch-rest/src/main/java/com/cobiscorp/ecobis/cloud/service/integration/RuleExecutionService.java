package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleAmountMaxResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

public class RuleExecutionService extends RestServiceBase {
	private static final ILogger logger = LogFactory
			.getLogger(RuleExecutionService.class);

	public RuleExecutionService(ICTSServiceIntegration integration) {
		super(integration);
		// TODO Auto-generated constructor stub
	}

	public ServiceResponse readRuleAmountMax(int requestId, String id_rule) {
		logger.logDebug("Inicio de Servicio readRuleAmounMax");
		RuleRequest ruleRequest = new RuleRequest();
		ruleRequest.setIdRequested(requestId);
		ruleRequest.setIdRule(id_rule);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();

		serviceRequestApplicationTO.addValue("inRuleRequest", ruleRequest);
		ServiceResponse serviceResponse = executeNormal(
				"Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd",
				serviceRequestApplicationTO);
		return serviceResponse;
		
	}
}
