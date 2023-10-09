package com.cobis.cloud.sofom.service.oxxo.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.DateRequest;
import cobiscorp.ecobis.systemconfiguration.dto.DateResponse;

import com.cobis.cloud.sofom.service.oxxo.common.RestServiceBase;
import com.cobis.cloud.sofom.service.oxxo.security.COBISSecurityManager;
import com.cobis.cloud.sofom.service.oxxo.security.SessionSecurityKey;
import com.cobis.cloud.sofom.service.oxxo.security.dto.CTSServiceResponseTO;
import com.cobiscorp.cobis.commons.exceptions.COBISException;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;

public class IntegrationServiceCommons extends RestServiceBase {
	private static final ILogger LOGGER = LogFactory.getLogger(IntegrationServiceOxxoPay.class);
	private ICTSServiceIntegration ctsServiceIntegration;

	public IntegrationServiceCommons(ICTSServiceIntegration integration) {
		super(integration);
		ctsServiceIntegration = integration;
	}

	public String getProcessDate(int dateFormat) throws COBISException {

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start getProcessDate");
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		try {
			CTSServiceResponseTO response = new CTSServiceResponseTO();
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			DateRequest dateRequestDTO = new DateRequest();

			dateRequestDTO.setDateFormat(dateFormat);

			serviceRequestTO.setServiceId("SystemConfiguration.ParameterManagement.ProcessDate");
			serviceRequestTO.addValue("inDateRequest", dateRequestDTO);
			SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
			COBISSecurityManager.clearSessionId(wSessionSecurityKey);

			if (!COBISSecurityManager.initializeSession(ctsServiceIntegration, wSessionSecurityKey, response)) {
				throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
			}

			serviceRequestTO.setSessionId(COBISSecurityManager.getSessionId(wSessionSecurityKey));
			ServiceRequest header = new ServiceRequest();
			header.addFieldInHeader("sessionId", 'S', serviceRequestTO.getSessionId());
			serviceRequestTO.addValue("com.cobiscorp.cobis.cts.service.header", header);
			serviceResponseTO = ctsServiceIntegration.getResponseFromCTS(serviceRequestTO);

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("getProcessDate --->" + dateFormat);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish getProcessDate");
		}
		return ((DateResponse) serviceResponseTO.getValue("returnDateResponse")).getProcessDate();

	}

}
