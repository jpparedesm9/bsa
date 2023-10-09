package com.cobiscorp.ecobis.collective.commons.services;

import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.constants.RequestName;
import com.cobiscorp.ecobis.collective.commons.constants.ServiceId;
import com.cobiscorp.ecobis.collective.commons.services.utils.CallServices;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.collective.dto.EntityRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ProcessAsesorManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ProcessAsesorManager.class);
	private ICTSServiceIntegration serviceIntegration;

	public ProcessAsesorManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.serviceIntegration = serviceIntegration;
	}

	public Map<String, Object> processAsesorEntity(AdvisorExternalRequest asesorRequest, ICommonEventArgs args) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.ADVISOR_EXTERNAL_REQUEST, asesorRequest);

		CallServices callService = new CallServices(serviceIntegration);
		return callService.callServiceWithOutput(RequestName.ADVISOR_EXTERNAL_REQUEST, asesorRequest, ServiceId.PROCESS_ASESOR_ENTITY, args);

	}

}
