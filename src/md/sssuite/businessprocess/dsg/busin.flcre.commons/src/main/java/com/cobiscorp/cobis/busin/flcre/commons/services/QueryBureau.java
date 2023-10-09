package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Created by ntrujillo on 03/07/2017.
 */
public class QueryBureau extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryBureau.class);

	public QueryBureau(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public BuroExecutionResponse queryBureau(Integer idEnte, Integer instProc, Integer channel) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso queryBureauIndividual");
		}

		try {
			ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
			ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
			validationProspectRequest.setCustomerId(idEnte);
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
					LOGGER.logDebug("QueryBureau.queryBureau-->buroExecutionResponseBlackList" + buroExecutionResponse);
				}

				if (buroExecutionResponse == null) {
					LOGGER.logDebug("Error al Consultar Listas Negras o Negative File");
					next = false;
				}

				if (buroExecutionResponse != null && buroExecutionResponse.getListBlackCustomer() != null && buroExecutionResponse.getListBlackCustomer() == 3) {
					next = false;
					LOGGER.logDebug("QueryBureau.queryBureau-->El cliente " + idEnte + " se encuentra en listas Negras o negative File, no continua");
				}
			} else {
				next = false;
			}

			if (next) {
				// com.cobiscorp.cobis.web.services.commons.model.ServiceResponse
				serviceResponse = this.execute(LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateBuro", new Object[] { validationProspectServiceRequest });
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("retrieve data BuroExecution Response " + serviceResponse.getData());
			}

			OrchestrationClientValidationResponse response = (OrchestrationClientValidationResponse) serviceResponse.getData();

			return response.getBuroResponse();

		} catch (Exception e) {
			LOGGER.logError("ERROR AL CONSULTAR BURÓ INDIVIDUAL ", e);
			throw e;
		}
	}

	public List<BuroExecutionResponse> queryBureau(Integer groupId, List<Integer> clientIds) throws Exception {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ingreso queryBureau");
		}

		try {

			BuroClientGroupRequest buroClientGroupRequest = new BuroClientGroupRequest();

			buroClientGroupRequest.setGroupId(groupId);

			buroClientGroupRequest.setClientIds(clientIds);

			com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(LOGGER,
					"OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup", new Object[] { buroClientGroupRequest });

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("retrieve data " + serviceResponse.getData());
			}

			return (List<BuroExecutionResponse>) serviceResponse.getData();

		} catch (Exception e) {
			LOGGER.logError("ERROR AL CONSULTAR BURÓ GRUPO ", e);
			throw e;
		}
	}
}
