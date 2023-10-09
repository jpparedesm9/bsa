package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 09/08/2017.
 */

public class ProcessInstanceInfo {
    private int processInstance;
    private String alternateCode;

    public int getProcessInstance() {
        return processInstance;
    }

    public ProcessInstanceInfo setProcessInstance(int processInstance) {
        this.processInstance = processInstance;
        return this;
    }

    public String getAlternateCode() {
        return alternateCode;
    }

    public ProcessInstanceInfo setAlternateCode(String alternateCode) {
        this.alternateCode = alternateCode;
        return this;
    }
}
