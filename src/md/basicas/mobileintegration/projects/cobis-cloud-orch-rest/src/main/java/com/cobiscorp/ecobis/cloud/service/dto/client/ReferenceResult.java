package com.cobiscorp.ecobis.cloud.service.dto.client;

public class ReferenceResult {

    private int referenceId;

    public ReferenceResult() {
    }

    public ReferenceResult(Integer referenceId) {
        this.referenceId = referenceId == null ? 0 : referenceId;
    }

    public int getReferenceId() {
        return referenceId;
    }

    public void setReferenceId(int referenceId) {
        this.referenceId = referenceId;
    }
}
