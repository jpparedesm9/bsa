package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.busin.model.CustomerDto;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class QueryBureauService extends ServiceBase {

	private ICTSServiceIntegration serviceIntegration;

	private static final ILogger LOGGER = LogFactory.getLogger(OfficerIntegrationService.class);

	public QueryBureauService(ICTSServiceIntegration serviceIntegration) {
		super();
		this.serviceIntegration = serviceIntegration;
	}

	//public ServiceResponse excuteQueryBureauForGroup(Integer groupId, List<CustomerDto> clients, String renapo, Integer channel) throws IntegrationException {
	public ServiceResponse excuteQueryBureauForGroup(List<CustomerDto> clients, String renapo, BuroClientGroupRequest buroClientGroupRequest) throws IntegrationException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start queryBureau");
		}
		String wInfo = "[QueryBureauService][excuteQueryBureauForGroup]";
		ServiceResponse serviceResponse = new ServiceResponse();
		StringBuilder errorMessage = new StringBuilder();

		LOGGER.logDebug(wInfo + ">>buroClientGroupRequest.toString(): " + buroClientGroupRequest.toString());
		try {

			List<Integer> clientIds = new ArrayList<Integer>();
			List<CustomerDto> buroRenapoRejected = new ArrayList<CustomerDto>();
			for (CustomerDto client : clients) {

				LOGGER.logDebug("Client: " + client.getId() + "- status: " + (client.getRenapoStatus() == null ? "0" : client.getRenapoStatus()));
				if (Constants.RENAPO_INACTIVE.equals(renapo)
						|| (Constants.RENAPO_ACTIVE.equals(renapo) && (client.getRenapoStatus() != null && Constants.RENAPO_VALIDATED.equals(client.getRenapoStatus().trim())))) {
					LOGGER.logDebug("1>>>" + client.getId());
					clientIds.add(client.getId());
				} else {
					LOGGER.logDebug("1>>>" + client.getId());
					errorMessage.append("-");
					errorMessage.append(client.getName());
					errorMessage.append("-");
					buroRenapoRejected.add(client);
				}
			}

			if (clientIds.size() > 0 && buroRenapoRejected.size() == 0) {
				buroClientGroupRequest.setClientIds(clientIds);
				ValidationBuroClientGroupServiceRequest validationBuroClientGroupServiceRequest = new ValidationBuroClientGroupServiceRequest();
				validationBuroClientGroupServiceRequest.setInBuroClientGroupRequest(buroClientGroupRequest);
				
				serviceResponse = this.execute(this.serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup",
						new Object[] { validationBuroClientGroupServiceRequest });

				LOGGER.logDebug("Resultado de invocación validateBuroClientGroup" + serviceResponse.isResult());

			} else {
				errorMessage.insert(0, "No se pudo consultar el buro de los clientes : ");
				errorMessage.insert(errorMessage.length() - 1, " porque no han sido validados en RENAPO. ");
				serviceResponse = new ServiceResponse();
				serviceResponse.setResult(false);
				serviceResponse.addMessage("500", errorMessage.toString());

			}
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish queryBureau");
			}
		}
		return serviceResponse;
	}

	public BuroExecutionResponse executeQueryBureau(int customerCode) {

		ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
		ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
		validationProspectRequest.setCustomerId(customerCode);
		validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);
		com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(this.serviceIntegration, LOGGER,
				"OrchestrationClientValidationServiceSERVImpl.validate", new Object[] { validationProspectServiceRequest });

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("retrieve data BuroExecution Response " + serviceResponse.getData());
		}

		OrchestrationClientValidationResponse response = (OrchestrationClientValidationResponse) serviceResponse.getData();

		return response.getBuroResponse();

	}
}
