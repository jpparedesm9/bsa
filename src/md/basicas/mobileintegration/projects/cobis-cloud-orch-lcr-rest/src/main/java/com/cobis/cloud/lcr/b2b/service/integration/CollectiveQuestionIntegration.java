package com.cobis.cloud.lcr.b2b.service.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CollectiveCustomerRequest;
import com.cobis.cloud.lcr.b2b.service.common.IntegrationException;
import com.cobis.cloud.lcr.b2b.service.common.RestServiceBase;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.google.gson.Gson;


public class CollectiveQuestionIntegration
  extends RestServiceBase
{
  private final ILogger LOGGER = LogFactory.getLogger(CollectiveQuestionIntegration.class);
  private final String CLASS_NAME = "[CollectiveQuestionIntegration] ";

  
  public CollectiveQuestionIntegration(ICTSServiceIntegration integration) { super(integration); }


  
  public boolean updateCollectiveCustomerInfo(CollectiveCustomerRequest collectiveCustomerRequest) throws IntegrationException {
    ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
    serviceRequestTO.setServiceId("CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer");
    serviceRequestTO.addValue("inCollectiveCustomerRequest", collectiveCustomerRequest);
    
    this.LOGGER.logDebug("INGRESANDO A IDOCUMENT LCR REQUEST ---> " + serviceRequestTO.getData());
    ServiceResponse serviceResponse = execute("CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer", serviceRequestTO);
    
    if (serviceResponse != null && serviceResponse.isResult()) {
      
      if (this.LOGGER.isDebugEnabled()) {
        Gson gson = new Gson();
        this.LOGGER.logDebug("[CollectiveQuestionIntegration] [CustomerDataManagementService][ServiceResponse]:" + gson.toJson(serviceResponse));
      } 

      
      return true;
    } 
    
    return false;
  }
}
