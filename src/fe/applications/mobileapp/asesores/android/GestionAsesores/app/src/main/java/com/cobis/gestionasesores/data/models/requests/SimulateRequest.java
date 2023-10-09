package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by User on 09/08/2017.
 */

public class SimulateRequest {

    private SimulationInfo simulation;
    private boolean online;

    public SimulationInfo getSimulation() {
        return simulation;
    }

    public boolean isOnline() {
        return online;
    }

    public void setSimulation(SimulationInfo simulation) {
        this.simulation = simulation;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }
}
