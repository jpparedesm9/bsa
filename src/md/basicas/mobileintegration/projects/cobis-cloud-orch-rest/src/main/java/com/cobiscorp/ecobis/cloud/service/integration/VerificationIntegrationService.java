package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.verification.VerificationResult;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

public class VerificationIntegrationService extends RestServiceBase {

    private final ILogger logger = LogFactory.getLogger(GroupIntegrationService.class);

    public VerificationIntegrationService(ICTSServiceIntegration integration) {
        super(integration);
    }


    public void updateDataVerification(DataVerificationRequest request) {

        logger.logDebug("-----Inicio DataVerificationManagement - updateDataVerification");
        ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
        serviceRequestApplicationTO.addValue("inDataVerificationRequest", request);
        ServiceResponse serviceResponse = this.execute("Businessprocess.Creditmanagement.DataVerification.UpdateVerification", serviceRequestApplicationTO);
        logger.logDebug("updateApplication serviceResponse" + serviceResponse);
    }

    public VerificationResult getResultVerification(DataVerificationRequest request) {
        logger.logDebug("-----Inicio DataVerificationManagement - searchDataVerification");
        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        serviceRequestTO.addValue("inDataVerificationRequest", request);
        ServiceResponse serviceResponse = this.execute("Businessprocess.Creditmanagement.DataVerification.SearchVerification", serviceRequestTO);

        ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();

        DataVerificationResponse[] responses = (DataVerificationResponse[]) serviceItemsResponseTO.getValue("returnDataVerificationResponse");
        VerificationResult result = new VerificationResult();
        if (responses != null && responses.length > 0) {
            result.setResult(responses[0].getResult());
        }

        return result;
    }


    public void updateVerificationStatus(int applicationNumber) {

        logger.logDebug("-----Inicio DataVerificationManagement - updateVerificationStatus");

        SynchronizationRequest request = new SynchronizationRequest();
        request.setApplicationNumber(applicationNumber);
        request.setSynchronization("S");
        ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
        serviceRequestApplicationTO.addValue("inSynchronizationRequest", request);
        ServiceResponse serviceResponse = this.execute("Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity", serviceRequestApplicationTO);
        logger.logDebug("updateVerificationStatus serviceResponse" + serviceResponse);
    }

}
