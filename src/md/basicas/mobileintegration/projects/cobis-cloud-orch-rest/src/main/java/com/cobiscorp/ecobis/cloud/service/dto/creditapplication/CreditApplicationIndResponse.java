package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class CreditApplicationIndResponse {

    ServiceResponse processInstance;
    ServiceResponse creditApplication;
    ServiceResponse evaluatePolitics;
    ServiceResponse completeTask;

    public ServiceResponse getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(ServiceResponse processInstance) {
        this.processInstance = processInstance;
    }

    public ServiceResponse getCreditApplication() {
        return creditApplication;
    }

    public void setCreditApplication(ServiceResponse creditApplication) {
        this.creditApplication = creditApplication;
    }

    public ServiceResponse getEvaluatePolitics() {
        return evaluatePolitics;
    }

    public void setEvaluatePolitics(ServiceResponse evaluatePolitics) {
        this.evaluatePolitics = evaluatePolitics;
    }

    public ServiceResponse getCompleteTask() {
        return completeTask;
    }

    public void setCompleteTask(ServiceResponse completeTask) {
        this.completeTask = completeTask;
    }
}
