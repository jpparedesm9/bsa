package com.cobiscorp.ecobis.cloud.service.dto.group;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

public class GroupRequestData extends GroupData implements InputData {

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
