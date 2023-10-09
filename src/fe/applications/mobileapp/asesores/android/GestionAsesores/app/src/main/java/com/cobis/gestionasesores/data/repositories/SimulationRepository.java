package com.cobis.gestionasesores.data.repositories;

import com.cobis.gestionasesores.data.mappers.SimulationMapper;
import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.SimulationResult;
import com.cobis.gestionasesores.data.models.responses.SimulationResponse;
import com.cobis.gestionasesores.data.source.SimulationDataSource;
import com.cobis.gestionasesores.data.source.remote.SimulationService;

/**
 * Created by User on 09/08/2017.
 */

public final class SimulationRepository implements SimulationDataSource {
    private static SimulationRepository sInstance = null;

    public static SimulationRepository getInstance() {
        if (sInstance == null) {
            sInstance = new SimulationRepository();
        }
        return sInstance;
    }

    private SimulationRepository() {
    }

    @Override
    public SimulationResult simulate(SimulationData request) throws Exception {
        SimulationService service = new SimulationService();
        SimulationResponse response = service.simulate(SimulationMapper.toSimulationRequest(request));
        if (response.isResult()) {
            return new SimulationResult(true, response.getData().getRate(), SimulationMapper.toMonthlyPayment(response.getData().getAmortizationTable()), response.getFirstMessage());
        } else {
            return new SimulationResult(false,0, null, response.getFirstMessage());
        }
    }
}
