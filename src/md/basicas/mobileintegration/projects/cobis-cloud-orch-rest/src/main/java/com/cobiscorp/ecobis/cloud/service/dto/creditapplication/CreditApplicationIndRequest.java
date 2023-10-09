package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

public class CreditApplicationIndRequest {

    private CustomerData customerData;
    private ApplicationData applicationData;
    private boolean confirmation;

    public CustomerData getCustomerData() {
        return customerData;
    }

    public void setCustomerData(CustomerData customerData) {
        this.customerData = customerData;
    }

    public ApplicationData getApplicationData() {
        return applicationData;
    }

    public void setApplicationData(ApplicationData applicationData) {
        this.applicationData = applicationData;
    }

	public boolean isConfirmation() {
		return confirmation;
	}

	public void setConfirmation(boolean confirmation) {
		this.confirmation = confirmation;
	}
    
}
