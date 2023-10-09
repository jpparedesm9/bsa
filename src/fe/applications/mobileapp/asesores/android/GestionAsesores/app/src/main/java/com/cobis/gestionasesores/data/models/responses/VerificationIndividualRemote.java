package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class VerificationIndividualRemote {
    private int processInstance;
    private List<VerificationRemote> verification;

    public List<VerificationRemote> getVerification() {
        return verification;
    }

    public void setVerification(List<VerificationRemote> verification) {
        this.verification = verification;
    }

    public int getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(int processInstance) {
        this.processInstance = processInstance;
    }
}
