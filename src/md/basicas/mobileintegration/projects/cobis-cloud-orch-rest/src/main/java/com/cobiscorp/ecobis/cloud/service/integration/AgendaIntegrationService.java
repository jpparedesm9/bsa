package com.cobiscorp.ecobis.cloud.service.integration;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.AgendaRequest;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.agenda.AgendaDataRequest;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;
import com.google.gson.Gson;

/**
 * Created by farid on 8/2/2017.
 */
public class AgendaIntegrationService extends RestServiceBase {
    private final ILogger logger = LogFactory.getLogger(AgendaIntegrationService.class);
    private final String className = "[AgendaIntegrationService] ";

    public AgendaIntegrationService(ICTSServiceIntegration integration) {
        super(integration);
    }

    public void updateAgendaStatus(AgendaDataRequest agendaDataRequest){

        AgendaRequest agendaRequest = new AgendaRequest();
        agendaRequest.setId(agendaDataRequest.getAgenda().getAgendaId());
        agendaRequest.setStatus(agendaDataRequest.getAgenda().getStatus());
        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        serviceRequestTO.addValue("inAgendaRequest", agendaRequest);
        ServiceResponse serviceResponse =  this.execute("AgendaManagement.AgendaManagement.UpdateStatus", serviceRequestTO);
        if(logger.isDebugEnabled()){
            Gson gson = new Gson();
            logger.logDebug(className + "[updateAgendaStatus][ServiceResponse]:" + gson.toJson(serviceResponse));
        }
    }
}
