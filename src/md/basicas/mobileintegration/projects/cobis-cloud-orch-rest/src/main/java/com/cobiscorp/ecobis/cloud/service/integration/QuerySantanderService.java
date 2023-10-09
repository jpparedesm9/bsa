package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest;

public class QuerySantanderService extends ServiceBase  {
	
	private ICTSServiceIntegration serviceIntegration;
	
	private static final ILogger LOGGER = LogFactory.getLogger(QuerySantanderService.class);

	public QuerySantanderService(ICTSServiceIntegration serviceIntegration) {
		super();
        this.serviceIntegration = serviceIntegration;
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

        com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(this.serviceIntegration,LOGGER,
                "OrchestrationClientValidationServiceSERVImpl.getSantanderInfoForGroup", new Object[]{validationBuroClientGroupServiceRequest});
        
        if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ejecuto executeQuerySantanderForGroup");
		}

    }

}
