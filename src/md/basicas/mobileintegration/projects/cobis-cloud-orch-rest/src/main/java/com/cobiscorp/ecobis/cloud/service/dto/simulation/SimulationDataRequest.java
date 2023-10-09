package com.cobiscorp.ecobis.cloud.service.dto.simulation;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

public class SimulationDataRequest extends SimulationData implements InputData {

    private boolean online;

    @Override
    public boolean isOnline() {
        return online;
    }

    @Override
    public void setOnline(boolean online) {
        this.online = online;
    }
}
