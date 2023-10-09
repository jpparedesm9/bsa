package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.busin.model.CustomerDto;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class QueryRulesService extends ServiceBase {
	private ICTSServiceIntegration serviceIntegration;

	private static final ILogger LOGGER = LogFactory.getLogger(QueryRulesService.class);

	public QueryRulesService(ICTSServiceIntegration serviceIntegration) {
		super();
		this.serviceIntegration = serviceIntegration;
	}

	public void executeQueryRules(Integer groupId, List<CustomerDto> clients) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeQueryRules");
		}

		List<Integer> clientIds = new ArrayList<Integer>();
		for (CustomerDto client : clients) {
			clientIds.add(client.getId());
		}

		BuroClientGroupRequest buroClientGroupRequest = new BuroClientGroupRequest();
		buroClientGroupRequest.setGroupId(groupId);
		buroClientGroupRequest.setClientIds(clientIds);
		ValidationBuroClientGroupServiceRequest validationBuroClientGroupServiceRequest = new ValidationBuroClientGroupServiceRequest();

		validationBuroClientGroupServiceRequest.setInBuroClientGroupRequest(buroClientGroupRequest);

		com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(this.serviceIntegration, LOGGER,
				"OrchestrationClientValidationServiceSERVImpl.getMatrixRulesInfoForGroup", new Object[] { validationBuroClientGroupServiceRequest });

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ejecuto executeQueryRules");
		}

	}

}
