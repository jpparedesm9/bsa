package com.cobis.cloud.sofom.service.seguros.common;


import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import static com.cobis.cloud.sofom.service.seguros.common.ServiceResponseTool.clearCodesInMessages;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;


public abstract class RestServiceBase extends ServiceBase {

    private final ILogger logger = LogFactory.getLogger(RestServiceBase.class);
    private ICTSServiceIntegration integration;

    public RestServiceBase(ICTSServiceIntegration integration) {
	this.integration = integration;
    }

    protected ServiceResponse execute(String serviceId, ServiceRequestTO serviceRequest) {
	ServiceResponse response = super.execute(integration, logger, serviceId, serviceRequest);
	clearCodesInMessages(response);
	if (!response.isResult()) {
	    throw new IntegrationException(response);
	}
	return response;
    }
    
    protected ServiceResponse executeNormal(String serviceId, ServiceRequestTO serviceRequest) {
        ServiceResponse response = super.execute(integration, logger, serviceId, serviceRequest);
        clearCodesInMessages(response);
        return response;
    }
}
