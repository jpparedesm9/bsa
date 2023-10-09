package com.cobiscorp.cobis.platform.web.servlet.util;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.CredentialsRequest;
import cobiscorp.ecobis.htm.api.dto.CredentialsResponse;

public class GetCredentialsImpl {

	private static final ILogger logger = LogFactory.getLogger(GetCredentialsImpl.class);
	private ICTSServiceIntegration serviceIntegration;
	
	public CredentialsDTO getCredentials(String sessionId){
		

		CredentialsDTO credentials = new CredentialsDTO();
		
		try
	    {

        ServiceRequestTO requestTO = new ServiceRequestTO();   
        ServiceResponseTO responseTO = new ServiceResponseTO();
		  
		ServiceBase serviceBase = new ServiceBase();
		ServiceResponse serviceResponse = new ServiceResponse();
		CredentialsRequest credentialsRequest= new CredentialsRequest();
		CredentialsResponse credentialsResponse = new CredentialsResponse();
		
		serviceBase.setSessionId(sessionId);
		credentialsRequest.setNameFileCredential("");
		
		requestTO.getData().put("inCredentialsRequest", credentialsRequest);
	    requestTO.getData().put("outCredentialsResponse", credentialsRequest);
	    
		serviceResponse = serviceBase.execute(getServiceIntegration() , logger, "HTM.API.HumanTask.GetCredencials",requestTO);
		
		if (serviceResponse.isResult()) { 
			responseTO = (ServiceResponseTO)serviceResponse.getData();
			credentialsResponse = (CredentialsResponse) responseTO.getValue("returnCredentialsResponse");
		}
		
		credentials.setPassword(credentialsResponse.getPassword());
		credentials.setUserName(credentialsResponse.getUser());
		credentials.setServerName(credentialsResponse.getApplication());

        
	    } catch (Exception e) {
			logger.logDebug("Error en catch: ", e);
			
	    }
	    
		return credentials;
	} 
	
	
	 public ICTSServiceIntegration getServiceIntegration() {   
			return this.serviceIntegration;
		}
	 
	 public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		 logger.logDebug("Entro al setServiceIntegration: " + serviceIntegration);   
		 this.serviceIntegration = serviceIntegration;
	        
	    }
	 
	 public void unsetServiceIntegration(
	            ICTSServiceIntegration serviceIntegration) {
		 	logger.logDebug("Entro al unsetServiceIntegration: "); 
	        this.serviceIntegration = null;
	    }
	
}
