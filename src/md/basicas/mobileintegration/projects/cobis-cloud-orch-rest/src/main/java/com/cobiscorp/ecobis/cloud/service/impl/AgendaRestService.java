package com.cobiscorp.ecobis.cloud.service.impl;

import cobiscorp.ecobis.assets.cloud.dto.SolidarityPayment;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.AgendaService;
import com.cobiscorp.ecobis.cloud.service.ClientService;
import com.cobiscorp.ecobis.cloud.service.dto.agenda.AgendaDataRequest;
import com.cobiscorp.ecobis.cloud.service.integration.AddressIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.AgendaIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.BusinessService;
import com.cobiscorp.ecobis.cloud.service.integration.CustomerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.google.gson.Gson;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

/**
 * Created by farid on 8/2/2017.
 */
@Path("/cobis-cloud/mobile/agenda")
@Component
@Service({AgendaService.class})
@org.apache.felix.scr.annotations.Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class AgendaRestService  implements AgendaService {

    private final ILogger logger = LogFactory.getLogger(AgendaRestService.class);
    private AgendaIntegrationService agendaIntegrationService;

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Override
    public Response updateAgendaStatus(AgendaDataRequest agendaDataRequest) {
        logger.logInfo("Ejecutando desde servicio REST Clase: [AgendaIntegrationService] Metodo: [createSolidarityPayment] modo online: " + agendaDataRequest.isOnline());
        try {
            agendaIntegrationService.updateAgendaStatus(agendaDataRequest);
            return successResponse(null,"updateAgendaStatus");
        } catch (IntegrationException ie) {
            return errorResponse(ie);
        }
    }

    protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.agendaIntegrationService = new AgendaIntegrationService(serviceIntegration);
    }

    protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.agendaIntegrationService = new AgendaIntegrationService(serviceIntegration);

    }
}
