package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 18/08/2017.
 */

public class VerificationRequest {
    private VerificationRequestInternal verification;

    public VerificationRequestInternal getVerification() {
        return verification;
    }

    public void setVerification(VerificationRequestInternal verification) {
        this.verification = verification;
    }
}