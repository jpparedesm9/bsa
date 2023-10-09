package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import com.cobiscorp.cobis.web.services.commons.model.Message;

import java.util.List;

/**
 * Created by ntrujillo on 18/07/2017.
 */
public class InstanceProcessData {

    int processInstance;
    String alternateCode;

    public int getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(int processInstance) {
        this.processInstance = processInstance;
    }

    public String getAlternateCode() {
        return alternateCode;
    }

    public void setAlternateCode(String alternateCode) {
        this.alternateCode = alternateCode;
    }


}
