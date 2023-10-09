package com.cobis.cloud.sofom.service.oxxo.integration;

import cobiscorp.ecobis.bankingcorrespondent.dto.BankingCorrespondentRequestDTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobis.cloud.sofom.service.oxxo.common.RestServiceBase;
import com.cobis.cloud.sofom.service.oxxo.dto.OlsPagoRequest;
import com.cobis.cloud.sofom.service.oxxo.security.COBISSecurityManager;
import com.cobis.cloud.sofom.service.oxxo.security.SessionSecurityKey;
import com.cobis.cloud.sofom.service.oxxo.security.dto.CTSServiceResponseTO;
import com.cobis.cloud.sofom.service.oxxo.utils.OxxoConstants;
import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.exceptions.COBISException;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;

public class IntegrationServiceOxxoPay extends RestServiceBase {

	private static final ILogger LOGGER = LogFactory.getLogger(IntegrationServiceOxxoPay.class);
	private IntegrationServiceCommons integrationServiceCommons;
	private ICTSServiceIntegration integration;

	public IntegrationServiceOxxoPay(ICTSServiceIntegration integration) {
		super(integration);
	}

	public ServiceResponseTO pago(OlsPagoRequest olsPagoRequest) throws COBISException {
		ServiceResponseTO serviceResponseTO = null;

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start pago");

		try {

			CTSServiceResponseTO response = new CTSServiceResponseTO();
			ComponentLocator componentLocator = ComponentLocator.getInstance(this);
			ICTSServiceIntegration ctsServiceIntegration = componentLocator.find(ICTSServiceIntegration.class);
			integrationServiceCommons = new IntegrationServiceCommons(ctsServiceIntegration);

			LOGGER.logDebug("COMPONENT de ICTSServiceINtegration" + componentLocator.find(ICTSServiceIntegration.class));
			LOGGER.logDebug("ICTSServiceINtegration" + ctsServiceIntegration);

			double pagoCents = Double.parseDouble(olsPagoRequest.getAmount()) / 100;
			LOGGER.logDebug("PAGO ORIGINAL: " + olsPagoRequest.getAmount());
			LOGGER.logDebug("PAGO CENTAVOS: " + pagoCents);

			BankingCorrespondentRequestDTO banking = new BankingCorrespondentRequestDTO();
			banking.setCorrespondentName("OXXO");
			banking.setReference(olsPagoRequest.getClient());
			banking.setAmount(String.valueOf(pagoCents));
			banking.setCorrespondentTrxId(olsPagoRequest.getFolio());
			banking.setToken(olsPagoRequest.getToken());

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			serviceRequestTO.setServiceId("BankingCorrespondent.BankingCorrespondentPayment.Pay");
			serviceRequestTO.addValue("inBankingCorrespondentRequestDTO", banking);
			LOGGER.logDebug("INGRESANDO BANKING: " + serviceRequestTO.getData());

			SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
			COBISSecurityManager.clearSessionId(wSessionSecurityKey);

			if (!COBISSecurityManager.initializeSession(ctsServiceIntegration, wSessionSecurityKey, response)) {
				throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
			}

			String processDate = integrationServiceCommons.getProcessDate(OxxoConstants.FORMATO_FECHA_101);

			if (processDate != null) {
				String[] processDatePart = processDate.split("/");
				banking.setPaymentDate(processDatePart[0] + processDatePart[1] + processDatePart[2]);

			} else {
				throw new COBISException("ERROR: No se pudo obtener la fecha de proceso.");
			}

			serviceRequestTO.setSessionId(COBISSecurityManager.getSessionId(wSessionSecurityKey));
			ServiceRequest header = new ServiceRequest();
			header.addFieldInHeader("sessionId", 'S', serviceRequestTO.getSessionId());
			serviceRequestTO.addValue("com.cobiscorp.cobis.cts.service.header", header);
			serviceResponseTO = ctsServiceIntegration.getResponseFromCTS(serviceRequestTO);

		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish consulta");
		}

		return serviceResponseTO;
	}

}
