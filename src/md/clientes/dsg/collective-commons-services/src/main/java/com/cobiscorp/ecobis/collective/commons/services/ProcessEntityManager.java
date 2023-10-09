package com.cobiscorp.ecobis.collective.commons.services;

import java.util.Map;

import cobiscorp.ecobis.collective.dto.EntityRequest;
import cobiscorp.ecobis.collective.dto.ProspectFilename;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.collective.commons.constants.RequestName;
import com.cobiscorp.ecobis.collective.commons.constants.ServiceId;
import com.cobiscorp.ecobis.collective.commons.constants.ReturnName;

public class ProcessEntityManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ProcessEntityManager.class);
	private ICTSServiceIntegration serviceIntegration;

	public ProcessEntityManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public Map<String, Object> processCollectiveEntity(EntityRequest entityRequest, ICommonEventArgs args) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.ENTITY_REQUEST, entityRequest);

		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithOutputWithoutShowErrorMsg(RequestName.ENTITY_REQUEST, entityRequest, ServiceId.PROCESS_COLLECTIVE_ENTITY, args);

	}
	
	public Object validateProspectFilename(ProspectFilename prosFilename, ICommonEventArgs args) {
		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithReturn(
			RequestName.PROSPECT_FILENAME_REQUEST, prosFilename, 
			ServiceId.VALIDATE_PROSPECT_FILENAME,ReturnName.RETURN_PROSPECT_FILENAME, args);
	}

}
