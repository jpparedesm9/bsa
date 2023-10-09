package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

public class OfficerIntegrationService extends RestServiceBase {


    private final ILogger logger = LogFactory.getLogger(OfficerIntegrationService.class);

    private final String className = "[OfficerIntegrationService] ";


    public OfficerIntegrationService(ICTSServiceIntegration integration) {
        super(integration);
    }


    public OfficerResponse getOfficerByLogin(String login) throws BusinessException {
        logger.logInfo("start getOfficerByLogin");
        OfficerRequest officerRequest = new OfficerRequest();
        officerRequest.setLogin(login);
        officerRequest.setType("L");

        ServiceRequestTO requestTO = new ServiceRequestTO();
        requestTO.addValue("inOfficerRequest", officerRequest);

        ServiceResponse serviceResponse = this.execute("SystemConfiguration.OfficerManagement.SearchOfficer", requestTO);

        ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
        OfficerResponse[] officerResponses = (OfficerResponse[]) serviceResponseTO.getValue("returnOfficerResponse");
        return officerResponses != null && officerResponses.length > 0 ? officerResponses[0] : new OfficerResponse();
    }

    public int getOfficeId(String login) {
        OfficerResponse response = getOfficerByLogin(login);
        if (response == null) return 0;
        return response.getOfficerId();
    }


}

