package com.cobiscorp.ecobis.cobiscloudorchestration.rest.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.api.IOrchestrationBiocheckServiceRest;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto.Biocheck;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto.BiocheckRuleResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.service.BiocheckService;
import com.cobiscorp.ecobis.cobiscloudorchestration.rest.service.IntegrationException;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * @author fsanmiguel
 */
@Path("/cobis/web/OrchestrationBiocheckServiceRest")
@Component
@org.apache.felix.scr.annotations.Service({ com.cobiscorp.ecobis.cobiscloudorchestration.rest.api.IOrchestrationBiocheckServiceRest.class })
@org.apache.felix.scr.annotations.Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class OrchestrationBiocheckServiceRestImpl implements IOrchestrationBiocheckServiceRest {

	private static ILogger logger = LogFactory.getLogger(OrchestrationBiocheckServiceRestImpl.class);

	BiocheckService biocheckService;

	@Path("/save/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	@Override
	public Response save(@PathParam("id") int customerId, Biocheck data) {
		logger.logInfo("");
		try {
			BiocheckRuleResponse rulesResponse = biocheckService.createBiocheckRegistry(customerId, data);
			return Response.ok().entity(rulesResponse).build();
		} catch (IntegrationException ex) {
			logger.logError("Error creando registro biocheck", ex);
			return Response.serverError().entity(new BiocheckRuleResponse("Error en la ejecución del servicio")).build();
		} catch (Exception ex) {
			logger.logError("Error creando registro biocheck", ex);
			return Response.serverError().entity(new BiocheckRuleResponse(ex.getMessage())).build();
		}
	}

	@Path("/query/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@GET
	@Override
	public Response query(@PathParam("id") int customerId) {
		try {
			Biocheck biocheck = biocheckService.queryBiocheckRegistry(customerId);
			return Response.ok().entity(biocheck).build();
		} catch (NotFoundException ex) {
			logger.logError("Registro no encontrado", ex);
			return Response.status(404).entity(new BiocheckRuleResponse(ex.getMessage())).build();
		} catch (Exception ex) {
			logger.logError("Error consultando registro biocheck", ex);
			return Response.serverError().entity(new BiocheckRuleResponse(ex.getMessage())).build();
		}
	}

	@Path("/error/catalogo/{id}/{errorCode}/{tramite}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@POST
	@Override
	public Response error(@PathParam("id") int customerId, @PathParam("errorCode") String errorCode, @PathParam("tramite") int tramite) {
		String response = null;

		logger.logInfo("OrchestrationBiocheckServiceRest.error - INI");
		try {

			response = biocheckService.validateErrorBiocheck(customerId, errorCode, tramite);
			BiocheckRuleResponse rulesResponse = new BiocheckRuleResponse(response);
			return Response.ok().entity(rulesResponse).build();
		} catch (IntegrationException ex) {
			logger.logError("Error creando registro biocheck", ex);
			return Response.serverError().entity(new BiocheckRuleResponse("Error en la ejecución del servicio")).build();
		} catch (Exception ex) {
			logger.logError("Error creando registro biocheck", ex);
			return Response.serverError().entity(new BiocheckRuleResponse(ex.getMessage())).build();

		}

	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.biocheckService = new BiocheckService(serviceIntegration);

	}

	protected void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.biocheckService = new BiocheckService(null);

	}

}
