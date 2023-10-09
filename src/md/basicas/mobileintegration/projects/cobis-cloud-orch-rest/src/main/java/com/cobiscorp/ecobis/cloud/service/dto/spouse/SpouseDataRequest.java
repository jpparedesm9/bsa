package com.cobiscorp.ecobis.cloud.service.dto.spouse;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

public class SpouseDataRequest extends SpouseData implements InputData {

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
