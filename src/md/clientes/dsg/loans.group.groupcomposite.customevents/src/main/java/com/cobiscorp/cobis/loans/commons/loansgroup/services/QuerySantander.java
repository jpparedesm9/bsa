package com.cobiscorp.cobis.loans.commons.loansgroup.services;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest;

public class QuerySantander extends BaseEvent  {
	
	private static final ILogger LOGGER = LogFactory.getLogger(QuerySantander.class);

	public QuerySantander(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public void  executeQuerySantanderForGroup(Integer groupId, List<Integer> clientIds) {
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start executeQuerySantanderForGroup");
        }

        BuroClientGroupRequest buroClientGroupRequest = new BuroClientGroupRequest();

        buroClientGroupRequest.setGroupId(groupId);

        buroClientGroupRequest.setClientIds(clientIds);

        ValidationBuroClientGroupServiceRequest validationBuroClientGroupServiceRequest =
                new ValidationBuroClientGroupServiceRequest();

        validationBuroClientGroupServiceRequest.setInBuroClientGroupRequest(buroClientGroupRequest);

        com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(LOGGER,
                "OrchestrationClientValidationServiceSERVImpl.getSantanderInfoForGroup", new Object[]{validationBuroClientGroupServiceRequest});
        
        if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ejecuto executeQuerySantanderForGroup");
		}

    }

}
