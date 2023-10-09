package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationRequest;

import javax.xml.bind.annotation.XmlRootElement;

/**
 * Created by farid on 7/25/2017.
 */
@XmlRootElement(name = "creditGroupApplicationSynchronizedData")
public class CreditGroupApplicationSynchronizationData {

    private CreditApplicationRequest creditGroupApplication;

    public CreditGroupApplicationSynchronizationData() {
    }

    public CreditApplicationRequest getCreditGroupApplication() {
        return creditGroupApplication;
    }

    public void setCreditGroupApplication(CreditApplicationRequest creditGroupApplication) {
        this.creditGroupApplication = creditGroupApplication;
    }
}
