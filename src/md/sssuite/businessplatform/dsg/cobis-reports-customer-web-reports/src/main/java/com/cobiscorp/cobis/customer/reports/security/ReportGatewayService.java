package com.cobiscorp.cobis.customer.reports.security;


import java.io.IOException;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.customer.reports.security.dto.CTSServiceResponseTO;
import com.cobiscorp.cobis.customer.reports.security.service.common.IntegrationException;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;

public class ReportGatewayService extends ServiceBase {
	
	private final ILogger logger = LogFactory.getLogger(ReportGatewayService.class);
    private static final String className = "[ReportGatewayService]";
    private ICTSServiceIntegration integration;
    
    public ReportGatewayService(ICTSServiceIntegration integration) {
        this.integration = integration;
    }
    
    
    private ServiceResponse execute(String serviceId, ServiceRequestTO serviceRequest) {
        ServiceResponse response = super.execute(integration, logger, serviceId, serviceRequest);
        clearCodesInMessages(response);
        if (!response.isResult()) {
            throw new IntegrationException(response);
        }
        return response;
    }
    
    public void registService()
    {
    	
    	CTSServiceResponseTO response = new CTSServiceResponseTO();
    	
    	ComponentLocator componentLocator = ComponentLocator.getInstance(this);
    	ICTSServiceIntegration ctsServiceIntegration = componentLocator
                 .find(ICTSServiceIntegration.class);
    	 
    	SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
        COBISSecurityManager.ClearSessionId(wSessionSecurityKey);
        /*if (!COBISSecurityManager.initializeSession(ctsServiceIntegration,
                wSessionSecurityKey, response)) {
            if (logger.isErrorEnabled()) {
                logger.logError(response);
            }
            throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
        }*/
    }
    
    static void clearCodesInMessages(ServiceResponse response) {
        if (!response.isResult()) {
            if (response.getMessages() != null) {
                for (Message message : response.getMessages()) {
                    message.setMessage(
                            message.getMessage()
                                    .replaceAll("(\\[.*?\\])", "")
                                    .replaceAll("&apos;", "'")
                                    .trim()
                    );
                }
            }
        }
    }
    
}
