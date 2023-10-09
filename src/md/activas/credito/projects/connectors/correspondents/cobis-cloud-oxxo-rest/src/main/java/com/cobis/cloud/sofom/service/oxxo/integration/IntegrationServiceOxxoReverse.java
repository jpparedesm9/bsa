package com.cobis.cloud.sofom.service.oxxo.integration;

import cobiscorp.ecobis.bankingcorrespondent.dto.BankingCorrespondentReverseRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobis.cloud.sofom.service.oxxo.common.RestServiceBase;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsReversaRequest;
import com.cobis.cloud.sofom.service.oxxo.security.COBISSecurityManager;
import com.cobis.cloud.sofom.service.oxxo.security.SessionSecurityKey;
import com.cobis.cloud.sofom.service.oxxo.security.dto.CTSServiceResponseTO;
import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.exceptions.COBISException;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;

public class IntegrationServiceOxxoReverse extends RestServiceBase {

	private static final ILogger LOGGER = LogFactory.getLogger(IntegrationServiceOxxoPay.class);

	public IntegrationServiceOxxoReverse(ICTSServiceIntegration integration) {
		super(integration);
	}

	public ServiceResponseTO reverse(OlsReversaRequest olsReverseRequest) throws COBISException {
		ServiceResponseTO serviceResponseTO = null;
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start reverse");

		try {
			CTSServiceResponseTO response = new CTSServiceResponseTO();
			ComponentLocator componentLocator = ComponentLocator.getInstance(this);
			ICTSServiceIntegration ctsServiceIntegration = componentLocator.find(ICTSServiceIntegration.class);

			LOGGER.logDebug("COMPONENT de ICTSServiceINtegration" + componentLocator.find(ICTSServiceIntegration.class));
			LOGGER.logDebug("ICTSServiceINtegration" + ctsServiceIntegration);

			BankingCorrespondentReverseRequest banking = new BankingCorrespondentReverseRequest();

			banking.setCorrespondentTrxId(olsReverseRequest.getFolio());
			banking.setCorrespondentNamecorrespondentName("OXXO");
			banking.setToken(olsReverseRequest.getToken());

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			serviceRequestTO.setServiceId("BankingCorrespondent.BankingCorrespondentPayment.Reverse");
			serviceRequestTO.addValue("inBankingCorrespondentReverseRequest", banking);
			LOGGER.logDebug("INGRESANDO BANKING: " + serviceRequestTO.getData());

			SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
			COBISSecurityManager.clearSessionId(wSessionSecurityKey);

			LOGGER.logDebug("VERDADERO O FALSO: " + !COBISSecurityManager.initializeSession(ctsServiceIntegration, wSessionSecurityKey, response));

			if (!COBISSecurityManager.initializeSession(ctsServiceIntegration, wSessionSecurityKey, response)) {
				if (LOGGER.isErrorEnabled()) {
					LOGGER.logError(response);
				}
				throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
			}

			LOGGER.logDebug("sessionId: " + COBISSecurityManager.getSessionId(wSessionSecurityKey));
			LOGGER.logDebug("It is going to assign SessionId to ServiceRequestTO");

			serviceRequestTO.setSessionId(COBISSecurityManager.getSessionId(wSessionSecurityKey));

			LOGGER.logDebug("SECCION ID" + wSessionSecurityKey);
			LOGGER.logDebug("XXXXXXXXXXXX" + COBISSecurityManager.getSessionId(wSessionSecurityKey));

			LOGGER.logDebug("serviceRequestTO.sessionId: " + serviceRequestTO.getSessionId());

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("It is going to execute service");
				LOGGER.logDebug("serviceRequestTO.sessionId: " + serviceRequestTO.getSessionId());
			}

			LOGGER.logDebug("********************************************** INICIO DE HEADER ************************************************");

			ServiceRequest header = new ServiceRequest();

			LOGGER.logDebug("HEADER: " + header);

			header.addFieldInHeader("sessionId", 'S', serviceRequestTO.getSessionId());

			LOGGER.logDebug("HEADER: " + header);
			LOGGER.logDebug("HEADER getCTSMessageAsString(): " + header.getCTSMessageAsString());
			LOGGER.logDebug("HEADER getObjectRequest(): " + header.getObjectRequest());
			LOGGER.logDebug("HEADER getServiceRequestAsString(): " + header.getServiceRequestAsString());

			serviceRequestTO.addValue("com.cobiscorp.cobis.cts.service.header", header);

			LOGGER.logDebug("serviceRequestTO getBackEndId(): " + serviceRequestTO.getBackEndId());
			LOGGER.logDebug("serviceRequestTO getExternalApplicationId(): " + serviceRequestTO.getExternalApplicationId());
			LOGGER.logDebug("serviceRequestTO getExternalUserId(): " + serviceRequestTO.getExternalUserId());
			LOGGER.logDebug("serviceRequestTO getServiceId(): " + serviceRequestTO.getServiceId());
			LOGGER.logDebug("serviceRequestTO getSessionId(): " + serviceRequestTO.getSessionId());
			LOGGER.logDebug("serviceRequestTO getClass(): " + serviceRequestTO.getClass());

			LOGGER.logDebug("header readFieldInHeader: " + header.readFieldInHeader("sessionId"));
			LOGGER.logDebug("serviceRequestTO.header: " + serviceRequestTO.getValue("com.cobiscorp.cobis.cts.service.header"));

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("header: " + header.readFieldInHeader("sessionId"));
				LOGGER.logDebug("serviceRequestTO.header: " + serviceRequestTO.getValue("com.cobiscorp.cobis.cts.service.header"));
			}

			serviceResponseTO = ctsServiceIntegration.getResponseFromCTS(serviceRequestTO);
			LOGGER.logDebug("serviceResponseTO.isSuccess: " + serviceResponseTO.isSuccess());

		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish consulta");
		}

		return serviceResponseTO;
	}

}
