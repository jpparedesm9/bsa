package com.cobiscorp.ecobis.cloud.service.dto.business;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

public class BusinessDataRequest extends BusinessData implements InputData {

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
