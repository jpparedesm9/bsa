package com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment;

import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

/**
 * Created by farid on 7/24/2017.
 */
public class SolidarityPaymentRequest extends SolidarityPaymentCompleteData implements InputData{


    private boolean online;

    @Override
    public boolean isOnline() {
        return this.online;
    }

    @Override
    public void setOnline(boolean online) {
        this.online = online;
    }
}
