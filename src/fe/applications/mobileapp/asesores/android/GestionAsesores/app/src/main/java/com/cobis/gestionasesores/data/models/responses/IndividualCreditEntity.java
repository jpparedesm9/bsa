package com.cobis.gestionasesores.data.models.responses;

import com.cobis.gestionasesores.data.models.requests.IndividualApplicationData;
import com.cobis.gestionasesores.data.models.requests.IndividualCustomerData;

/**
 * Created by mnaunay on 23/08/2017.
 */

public class IndividualCreditEntity {
    private WrapEntity creditIndividualApplication;

    public WrapEntity getCreditIndividualApplication() {
        return creditIndividualApplication;
    }

    public void setCreditIndividualApplication(WrapEntity creditIndividualApplication) {
        this.creditIndividualApplication = creditIndividualApplication;
    }

    public class WrapEntity{
        private IndividualCustomerData customerData;
        private IndividualApplicationData applicationData;

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
}
