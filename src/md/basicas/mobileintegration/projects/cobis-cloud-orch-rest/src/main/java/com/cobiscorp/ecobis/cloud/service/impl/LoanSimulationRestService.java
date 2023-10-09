package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cloud.service.LoanSimulationService;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.AmortizationEntry;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.LoanSimulationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.LoanSimulationResponse;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.SimulationDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.SimulationDataResponse;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.SimulationDataResult;
import com.cobiscorp.ecobis.cloud.service.integration.LoanIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.LoanIntegrationService.LoanAmortizationTableResponse;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil.Function;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;

import cobiscorp.ecobis.assets.cloud.dto.LoanSimulatorResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * @author Cesar Loachamin
 */
@Path("/cobis-cloud/mobile/loan/simulation")
@Component
@Service({ LoanSimulationService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class LoanSimulationRestService implements LoanSimulationService {
	private final ILogger logger = LogFactory.getLogger(LoanSimulationRestService.class);
	private LoanIntegrationService integrationService;

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createAmortizationTable(SimulationDataRequest request) {
		logger.logInfo("/cobis-cloud/mobile/loan/simulation/createAmortizationTable Request>>" + objectToJson(request));

		try {
			LoanAmortizationTableResponse response = integrationService.createAmortizationTable(request.getSimulation().toRequest());
			if (response == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			AmortizationEntry[] entries = ArrayUtil.map(response.getEntries(), AmortizationEntry.class, new Function<LoanSimulatorResponse, AmortizationEntry>() {
				@Override
				public AmortizationEntry call(LoanSimulatorResponse obj) {
					return AmortizationEntry.fromResponse(obj);
				}
			});
			SimulationDataResult result = new SimulationDataResult(response.getRate(), entries);
			return successResponse(new SimulationDataResponse(createServiceResponse(result)), "/cobis-cloud/mobile/loan/simulation/createAmortizationTable");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/loan/simulation/createAmortizationTable Error al crear tabla de amortización", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/loan/simulation/createAmortizationTable Error al crear tabla de amortización", e);
			return errorResponse("/cobis-cloud/mobile/loan/simulation/createAmortizationTable Error al crear tabla de amortización");
		}
	}

	@Path("/simulate")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response createSimulate(LoanSimulationRequest simulationRequest) {
		logger.logInfo("/cobis-cloud/mobile/loan/simulation/createSimulate Request>>" + objectToJson(simulationRequest));
		try {
			LoanSimulationResponse response = integrationService.simulate(simulationRequest);
			if (response == null) {
				return errorResponse(Response.Status.NOT_FOUND);
			}
			return successResponse(response, "/cobis-cloud/mobile/loan/simulation/createSimulate");
		} catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/loan/simulation/createSimulate Error al crear simulacion", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/loan/simulation/createSimulate Error al crear simulacion", e);
			return errorResponse("/cobis-cloud/mobile/loan/simulation/createSimulate Error al crear simulacion");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationService = new LoanIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationService = new LoanIntegrationService(serviceIntegration);
	}
}
