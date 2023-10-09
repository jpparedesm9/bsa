package com.cobiscorp.cobis.assets.commons.services;

import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesRequest;
import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesResponse;
import cobiscorp.ecobis.assets.cloud.dto.OfficerCreditCandidatesResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.constants.RequestName;
import com.cobiscorp.cobis.assets.commons.constants.ReturnName;
import com.cobiscorp.cobis.assets.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CreditCandidatesManagement extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(CreditCandidatesManagement.class);

	public CreditCandidatesManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CreditCandidatesResponse[] queryCandidates(CreditCandidatesRequest candidatesRequest, IExecuteQueryEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start actionsCandidates");

		LOGGER.logDebug("getServiceIntegration(): " + this.getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.CANDIDATES_REQUEST, candidatesRequest);
		ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, ServiceId.QUERY_CANDIDATES, serviceRequestApplicationTO);
		if (serviceResponse == null) {
			arg1.getMessageManager().showErrorMsg("Error al carga información.");
			arg1.setSuccess(false);
		} else {
			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
				return (CreditCandidatesResponse[]) serviceResponseItemsTO.getValue(ReturnName.CANDIDATES_RESPONSE);
			} else {
				arg1.setSuccess(false);
				for (Message message : serviceResponse.getMessages()) {
					arg1.getMessageManager().showErrorMsg(message.getMessage());
				}
				LOGGER.logError("Error al carga información.");
				return null;
			}
		}
		return null;
	}

	public OfficerCreditCandidatesResponse[] officerCandidates(CreditCandidatesRequest candidatesRequest, ILoadCatalogDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start actionsCandidates");

		LOGGER.logDebug("getServiceIntegration(): " + this.getServiceIntegration());
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.CANDIDATES_REQUEST, candidatesRequest);
		ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, ServiceId.OFFICER_CANDIDATES, serviceRequestApplicationTO);
		if (serviceResponse == null) {
			arg1.getMessageManager().showErrorMsg("Error al carga de catalogo de asesores.");
		} else {
			if (serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseItemsTO = (ServiceResponseTO) serviceResponse.getData();
				return (OfficerCreditCandidatesResponse[]) serviceResponseItemsTO.getValue(ReturnName.OFFICER_CANDIDATES_RESPONSE);
			} else {
				arg1.setSuccess(false);
				for (Message message : serviceResponse.getMessages()) {
					arg1.getMessageManager().showErrorMsg(message.getMessage());
				}
				LOGGER.logError("Error al carga de catalogo de asesores.");
				return null;
			}
		}
		return null;

	}

	public void updateCandidates(CreditCandidatesRequest candidatesRequest, ICommonEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start updateCandidates");

		LOGGER.logDebug("getServiceIntegration(): " + this.getServiceIntegration());
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.CANDIDATES_REQUEST, candidatesRequest);
		ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, ServiceId.UPDATE_CANDIDATES, serviceRequestTO);
		if (serviceResponse == null) {
			arg1.getMessageManager().showErrorMsg("Error al actualizar.");
		} else {
			if (!serviceResponse.isResult()) {
				arg1.setSuccess(false);
				for (Message message : serviceResponse.getMessages()) {
					arg1.getMessageManager().showErrorMsg(message.getMessage());
				}
			}
		}

	}

	public void actionsCandidates(CreditCandidatesRequest candidatesRequest, ICommonEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start actionsCandidates");

		LOGGER.logDebug("getServiceIntegration(): " + this.getServiceIntegration());
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.CANDIDATES_REQUEST, candidatesRequest);
		ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, ServiceId.ACTIONS_CANDIDATES, serviceRequestTO);
		if (serviceResponse == null) {
			arg1.getMessageManager().showErrorMsg("Error al intentar aplicar acción.");
		} else {
			if (!serviceResponse.isResult()) {
				arg1.setSuccess(false);
				for (Message message : serviceResponse.getMessages()) {
					arg1.getMessageManager().showErrorMsg(message.getMessage());
				}
			}
		}
	}
}
