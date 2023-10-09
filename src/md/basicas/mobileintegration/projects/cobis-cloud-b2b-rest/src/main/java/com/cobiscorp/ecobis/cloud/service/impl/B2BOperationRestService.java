package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.successResponse;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.B2BOperationService;
import com.cobiscorp.ecobis.cloud.service.common.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.dto.OperationDataResponse;
import com.cobiscorp.ecobis.cloud.service.integration.OperationIntegration;

@Path("/cobis-cloud/mobile/b2b/operationService")
@Component
@Service({ B2BOperationService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class B2BOperationRestService implements B2BOperationService {

	private final ILogger LOGGER = LogFactory.getLogger(B2BOperationRestService.class);
	private OperationIntegration operationIntegration;

	@Path("searchOperations/{clientGroupCode}/{type}/{correspondent}")
	@GET
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response searchOperations(@PathParam("clientGroupCode") Integer clientGroupCode, @PathParam("type") String type, @PathParam("correspondent") String correspondent) {
		try {	
			ServiceResponse response = new ServiceResponse();
			OperationDataResponse operationResponse = new OperationDataResponse();
			operationResponse.setOperations(operationIntegration.searchOperations(clientGroupCode, type, correspondent));			
			response.setResult(true);
			response.setData(operationResponse);
			return successResponse(response);
		} catch (IntegrationException ie) {
			LOGGER.logError("/cobis-cloud/mobile/b2b/operationService/searchOperations Error en la consulta de operaciones ", ie);
			return successResponse(ie.getResponse());
		} catch (Exception e) {
			LOGGER.logError("/cobis-cloud/mobile/b2b/operationService/searchOperations Error en la consulta de operaciones ", e);
			return errorResponse("/cobis-cloud/mobile/b2b/operationService/searchOperations Error en la consulta de operaciones ");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.operationIntegration = new OperationIntegration(serviceIntegration);

	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.operationIntegration = new OperationIntegration(serviceIntegration);

	}

}
