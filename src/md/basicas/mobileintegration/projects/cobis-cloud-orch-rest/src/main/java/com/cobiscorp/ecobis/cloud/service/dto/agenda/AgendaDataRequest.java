package com.cobiscorp.ecobis.cloud.service.dto.agenda;

import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessData;
import com.cobiscorp.ecobis.cloud.service.dto.common.InputData;

/**
 * Created by farid on 8/2/2017.
 */
public class AgendaDataRequest extends AgendaData implements InputData {

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
