package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * Created by ntrujillo on 17/07/2017.
 */
public class CreditApplicationIncompleteResponse {

    ServiceResponse processInstance;
    ServiceResponse creditApplication;
    ServiceResponse amounts;
  
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

	public ServiceResponse getAmounts() {
		return amounts;
	}

	public void setAmounts(ServiceResponse amounts) {
		this.amounts = amounts;
	}

 

}
