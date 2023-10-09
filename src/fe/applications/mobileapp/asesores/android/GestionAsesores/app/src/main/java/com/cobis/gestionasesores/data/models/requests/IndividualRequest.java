package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by jescudero on 17/08/2017.
 */

public class IndividualRequest {
    private IndividualCustomerData customerData;
    private IndividualApplicationData applicationData;
    private boolean confirmation;

    public boolean isConfirmation() {
        return confirmation;
    }

    public void setConfirmation(boolean confirmation) {
        this.confirmation = confirmation;
    }

    public IndividualCustomerData getCustomerData() {
        return customerData;
    }

    public void setCustomerData(IndividualCustomerData customerData) {
        this.customerData = customerData;
    }

    public IndividualApplicationData getApplicationData() {
        return applicationData;
    }

    public void setApplicationData(IndividualApplicationData applicationData) {
        this.applicationData = applicationData;
    }
}


