package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.SimulationResult;

/**
 * Created by User on 09/08/2017.
 */

public interface SimulationDataSource {
    SimulationResult simulate (SimulationData request) throws Exception;
}
