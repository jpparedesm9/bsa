package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by User on 09/08/2017.
 */

public class SimulationResponse extends GenericResponse {
    private SimulationRemote data;

    public SimulationRemote getData() {
        return data;
    }

    public void setData(SimulationRemote data) {
        this.data = data;
    }
}
