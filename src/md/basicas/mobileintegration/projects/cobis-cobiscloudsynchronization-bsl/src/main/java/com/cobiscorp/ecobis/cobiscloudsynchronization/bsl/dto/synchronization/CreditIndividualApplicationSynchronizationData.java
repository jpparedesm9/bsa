package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationIndRequest;

import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by farid on 7/26/2017.
 */
@XmlRootElement(name = "creditIndividualApplicationSynchronizedData")
public class CreditIndividualApplicationSynchronizationData {
    private CreditApplicationIndRequest creditIndividualApplication;

    public CreditIndividualApplicationSynchronizationData() {
    }

    public CreditApplicationIndRequest getCreditIndividualApplication() {
        return creditIndividualApplication;
    }

    public void setCreditIndividualApplication(CreditApplicationIndRequest creditIndividualApplication) {
        this.creditIndividualApplication = creditIndividualApplication;
    }
}
