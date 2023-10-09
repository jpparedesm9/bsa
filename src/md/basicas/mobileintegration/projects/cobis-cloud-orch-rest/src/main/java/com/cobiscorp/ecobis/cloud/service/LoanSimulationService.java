package com.cobiscorp.ecobis.cloud.service;

import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.cloud.service.dto.simulation.LoanSimulationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.SimulationDataRequest;

public interface LoanSimulationService {

    Response createAmortizationTable(SimulationDataRequest request);

    Response createSimulate(LoanSimulationRequest simulationRequest);

}
