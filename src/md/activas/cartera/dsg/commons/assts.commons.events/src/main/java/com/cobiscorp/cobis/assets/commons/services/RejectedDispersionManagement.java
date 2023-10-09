package com.cobiscorp.cobis.assets.commons.services;

import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsRequest;
import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class RejectedDispersionManagement extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(RejectedDispersionManagement.class);

	public RejectedDispersionManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public RejectedDispersionsResponse[] searchRejectedDispersions(RejectedDispersionsRequest rejectedDispersionsRequest) {
		LOGGER.logDebug("getServiceIntegration(): " + getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(Parameter.DISPERSIONS_REQUEST, rejectedDispersionsRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), LOGGER, Parameter.SEARCHDISPERSIONS, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
			return (RejectedDispersionsResponse[]) serviceResponseItemsTO.getValue(Parameter.DISPERSIONS_RESPONSE);
		} else {
			LOGGER.logError("Error en el servicio de consulta de Rejected Dispersions");
			return null;
		}

	}

	public void dispersionActions(RejectedDispersionsRequest rejectedDispersionsRequest, ICommonEventArgs arg1) {

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start dispersionActions");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(Parameter.DISPERSIONS_REQUEST, rejectedDispersionsRequest);
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, Parameter.ACTIONDISPERSIONS, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					arg1.setSuccess(true);
				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}
					arg1.setSuccess(false);
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish dispersionActions");
		}
	}
}
