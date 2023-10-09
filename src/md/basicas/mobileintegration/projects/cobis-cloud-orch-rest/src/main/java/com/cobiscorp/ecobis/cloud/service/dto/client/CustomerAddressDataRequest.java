package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

/**
 * @author Cesar Loachamin
 */
public class CustomerAddressDataRequest extends CustomerAddressData implements InputData {

    private boolean online;

    public CustomerAddressDataRequest() {
    }

    @Override
    public boolean isOnline() {
        return online;
    }

    @Override
    public void setOnline(boolean online) {
        this.online = online;
    }
}
