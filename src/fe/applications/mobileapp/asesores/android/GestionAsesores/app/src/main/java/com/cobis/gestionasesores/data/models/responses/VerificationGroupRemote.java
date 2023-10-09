package com.cobis.gestionasesores.data.models.responses;

import java.util.List;

/**
 * Created by mnaunay on 16/08/2017.
 */

public class VerificationGroupRemote {
    private int groupId;
    private String name;
    private int processInstance;
    private List<VerificationRemote> verification;

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<VerificationRemote> getVerification() {
        return verification;
    }

    public int getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(int processInstance) {
        this.processInstance = processInstance;
    }

    public void setVerification(List<VerificationRemote> verification) {
        this.verification = verification;
    }
}