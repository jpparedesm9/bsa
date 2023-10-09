package com.cobiscorp.ecobis.cloud.service.dto.simulation;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class SimulationDataResponse {

    private ServiceResponse simulation;

    public SimulationDataResponse() {
    }

    public SimulationDataResponse(ServiceResponse simulation) {
        this.simulation = simulation;
    }

    public ServiceResponse getSimulation() {
        return simulation;
    }

    public void setSimulation(ServiceResponse simulation) {
        this.simulation = simulation;
    }
}
