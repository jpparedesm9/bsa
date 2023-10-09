/**
 * Archivo: SynchronizeServiceRestImpl.java
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsynchronization.rest.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.codehaus.jackson.map.ObjectMapper;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetDataSynchronizeRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetEntitiesDataRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.UpdateDataSynchronizeRequest;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

//incluir en code order con la clave:cobiscloudsynchronization.SynchronizeServiceRestImpl.imports

@Path("/cobis-cloud/mobile/synchronize")
@Component
@org.apache.felix.scr.annotations.Service({com.cobiscorp.ecobis.cobiscloudsynchronization.rest.api.ISynchronizeServiceRest.class})
public class SynchronizeServiceRestImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudsynchronization.rest.api.ISynchronizeServiceRest {

    @Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
    private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(SynchronizeServiceRestImpl.class);

    public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.serviceIntegration = serviceIntegration;
    }

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.serviceIntegration = null;
    }

    @Path("/getDataToSynchronize")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @PUT
    @Override
	public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse getDataToSynchronize(GetDataSynchronizeRequest request) {
        logger.logDebug(".......---------SynchronizeServiceSERVImpl.getDataToSynchronize");
		logger.logDebug("/cobis-cloud/mobile/synchronize/getDataToSynchronize/ REQUEST>>" + objectToJson(request));

		return this.execute(serviceIntegration, logger, "SynchronizeServiceSERVImpl.getDataToSynchronize", new Object[] { request });
    }

    @Path("/updateDataToSynchronize")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @PUT
    @Override
	public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse updateDataToSynchronize(UpdateDataSynchronizeRequest request) {
		logger.logDebug(".......---------SynchronizeServiceSERVImpl.updateDataToSynchronize" + objectToJson(request));
		logger.logDebug("/cobis-cloud/mobile/synchronize//updateDataToSynchronize/ REQUEST>>" + objectToJson(request));
		return this.execute(serviceIntegration, logger, "SynchronizeServiceSERVImpl.updateDataToSynchronize", new Object[] { request });
    }

    @Path("/getEntitiesData/{entity}/{idSync}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @GET
    @Override
	public com.cobiscorp.cobis.web.services.commons.model.ServiceResponse getEntitiesData(@PathParam("entity") String entity, @PathParam("idSync") int idSync, @QueryParam("page") int page, @QueryParam("per_page") int perPage) {

		logger.logDebug("***** Parametros de ingreso: *****");
		logger.logDebug("/cobis-cloud/mobile/synchronize/getEntitiesData/{entity}/{idSync}" + " --> "+ entity + " / " + idSync + " / " + page + " / " + perPage );
        GetEntitiesDataRequest request = new GetEntitiesDataRequest();
        request.setEntity(entity);
        request.setIdSync(idSync);
        request.setPage(page);
        request.setPerPage(perPage);
        logger.logDebug(".......---------SynchronizeServiceSERVImpl.getEntitiesData");
		ServiceResponse response = this.execute(serviceIntegration, logger, "SynchronizeServiceSERVImpl.getEntitiesData", new Object[] { request });
        logger.logDebug("/cobis-cloud/mobile/synchronize/getEntitiesData/ RESPONSE>>"+objectToJson(response));
        return response;
    }
  
    public String objectToJson(Object obj){
    	ObjectMapper mapper = new ObjectMapper();
    	try {
			return mapper.writeValueAsString(obj); 
		} catch (Exception e) {
			logger.logError("Error al obtener trama JSON de respuesta:",e);
			return null;
		}
    }
}
