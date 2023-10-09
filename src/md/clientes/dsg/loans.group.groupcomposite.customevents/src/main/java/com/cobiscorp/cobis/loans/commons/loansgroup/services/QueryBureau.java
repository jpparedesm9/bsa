package com.cobiscorp.cobis.loans.commons.loansgroup.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.loansgroup.commons.constants.Constants;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CustomerDto;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class QueryBureau extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryBureau.class);

	public QueryBureau(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<BuroExecutionResponse> excuteQueryBureauForGroup(Integer groupId, List<CustomerDto> clients, String renapo, Integer instProc, Integer channel)
			throws BusinessException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start QueryBureau -- excuteQueryBureauForGroup");
		}

		ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();

		List<BuroExecutionResponse> buroExecutionResponseList = new ArrayList<BuroExecutionResponse>();

		for (CustomerDto client : clients) {

			if (Constants.RENAPO_INACTIVE.equals(renapo) || (Constants.RENAPO_ACTIVE.equals(renapo) && Constants.RENAPO_VALIDATED.equals(client.getRenapoStatus()))) {
				LOGGER.logDebug("Querybureau----> Grupo: " + groupId + "----> channel: " + channel);
				ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
				validationProspectRequest.setCustomerId(client.getId());
				validationProspectRequest.setInstProc(instProc);
				validationProspectRequest.setChannel(channel);
				validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);

				// Listas negras y negative file
				boolean next = true;
				ServiceResponse serviceResponse = this.execute(LOGGER, "OrchestrationClientValidationServiceSERVImpl.blackListValidation",
						new Object[] { validationProspectServiceRequest });

				if (serviceResponse.isResult()) {
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();
					BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("QueryBureau.excuteQueryBureauForGroup-->buroExecutionResponseBlackList" + buroExecutionResponse);
					}

					if (buroExecutionResponse == null) {
						LOGGER.logDebug("Error al Consultar Listas Negras o Negative File");
						next = false;
					}

					if (buroExecutionResponse != null && buroExecutionResponse.getListBlackCustomer() != null && buroExecutionResponse.getListBlackCustomer() == 3) {
						next = false;
						LOGGER.logDebug("QueryBureau.excuteQueryBureauForGroup-->El cliente " + client.getId() + " se encuentra en listas Negras o negative File, no continua");
					}
				} else {
					next = false;
				}

				if (next) {
					// com.cobiscorp.cobis.web.services.commons.model.ServiceResponse
					serviceResponse = this.execute(LOGGER, "OrchestrationClientValidationServiceSERVImpl.validate", new Object[] { validationProspectServiceRequest });
				}
				if (serviceResponse.isResult()) {
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();
					BuroExecutionResponse buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();
					buroExecutionResponseList.add(buroExecutionResponse);
					// buroExecutionResponse.getRuleExecutionResult();d
				}
			}
		}

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Finish  QueryBureau buroExecutionResponseList >>" + buroExecutionResponseList);
		}

		return buroExecutionResponseList;

	}
}
