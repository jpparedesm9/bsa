package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

/**
 * @author Cesar Loachamin
 */
public class PaymentCapacityDataRequest extends PaymentCapacityData implements InputData {

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
