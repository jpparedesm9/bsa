package com.cobiscorp.ecobis.collective.commons.services;

import java.util.Map;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.collective.dto.AdvisorExternalResponse;
import cobiscorp.ecobis.collective.dto.EntityRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.collective.commons.constants.RequestName;
import com.cobiscorp.ecobis.collective.commons.constants.ReturnName;
import com.cobiscorp.ecobis.collective.commons.constants.ServiceId;

public class AdvisorExternalManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(AdvisorExternalManager.class);
	private ICTSServiceIntegration serviceIntegration;

	public AdvisorExternalManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public AdvisorExternalResponse[] searchAdvisorExternal(AdvisorExternalRequest advisorExternalRequest, ICommonEventArgs arg1)  {
		CallServices callService = new CallServices(serviceIntegration);

		AdvisorExternalResponse[] advisorExternalResponse = callService.callServiceWithReturnArray(RequestName.ADVISOR_EXTERNAL_REQUEST, advisorExternalRequest, ServiceId.QUERRY_COLECTIVE, ReturnName.RETURN_QUERRYCOLECTIVE, arg1);
		return advisorExternalResponse == null ? new AdvisorExternalResponse[0] : advisorExternalResponse;
	}
	

}
