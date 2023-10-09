package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.successResponse;

import java.util.Arrays;

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

import cobiscorp.ecobis.businesstobusiness.dto.CustomerGroupResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.B2BClientService;
import com.cobiscorp.ecobis.cloud.service.common.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.dto.EntityDataResponse;
import com.cobiscorp.ecobis.cloud.service.integration.CustomerGroupIntegration;

@Path("/cobis-cloud/mobile/b2b/clientService")
@Component
@Service({ B2BClientService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class B2BClientRestService implements B2BClientService {
	private final ILogger LOGGER = LogFactory.getLogger(B2BClientRestService.class);

	private CustomerGroupIntegration customerGroupIntegration;

	@Path("/searchCustomerGroupByName/{name}/{type}/{sequential}")
	@GET
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response searchCustomerGroupByName(@PathParam("name") String name, @PathParam("type") String type,@PathParam("sequential") int sequential) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start searchClientGroup in B2BClientRestService");
		}
		try {
			
			CustomerGroupResponse[] customerGroupResponses = customerGroupIntegration.searchClientGroupByName(name, type, sequential);
			if (customerGroupResponses == null) {
				return null;
			} else {
				ServiceResponse response = new ServiceResponse();
				EntityDataResponse entityResponse = new EntityDataResponse();
				entityResponse.setEntity(Arrays.asList(customerGroupResponses));
				response.setResult(true);
				response.setData(entityResponse);
				return successResponse(response);
			}
		} catch (IntegrationException ie) {
			LOGGER.logError("/cobis-cloud/mobile/b2b/clientService/searchCustomerGroupByName Error en la consulta de cliente/grupo ", ie);
			return successResponse(ie.getResponse());
		} catch (Exception e) {
			LOGGER.logError("/cobis-cloud/mobile/b2b/clientService/searchCustomerGroupByName Error en la consulta de cliente/grupo ", e);
			return errorResponse("/cobis-cloud/mobile/b2b/clientService/searchCustomerGroupByName Error en la consulta de cliente/grupo");
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish searchClientGroup in B2BClientRestService");
			}
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.customerGroupIntegration = new CustomerGroupIntegration(serviceIntegration);

	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.customerGroupIntegration = new CustomerGroupIntegration(serviceIntegration);

	}

}
