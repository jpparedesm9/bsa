package com.cobiscorp.ecobis.cloud.service.dto.prospect;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

/**
 * @author Cesar Loachamin
 */
public class ProspectDataRequest extends ProspectData implements InputData {

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
