package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization;

import com.cobiscorp.ecobis.cloud.service.dto.client.Reference;

import java.util.List;

public class ReferenceSynchronizationData {
    List<Reference> reference;

    public List<Reference> getReference() {
        return reference;
    }

    public void setReference(List<Reference> reference) {
        this.reference = reference;
    }
}
