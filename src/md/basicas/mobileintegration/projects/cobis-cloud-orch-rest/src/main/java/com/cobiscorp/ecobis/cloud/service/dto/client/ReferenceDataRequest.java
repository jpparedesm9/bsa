package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

public class ReferenceDataRequest extends ReferenceData implements InputData {

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
