package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by mnaunay on 08/08/2017.
 */

public class CreditResponse extends GenericResponse{
    private CreditApplicationResponse creditApplication;
    private ProcessInstanceResponse processInstance;
    private UpdateAmountResponse updateAmounts;
    private GenericResponse evaluatePolitics;
    private GenericResponse completeTask;


    public ProcessInstanceResponse getProcessInstance() {
        return processInstance;
    }

    public void setProcessInstance(ProcessInstanceResponse processInstance) {
        this.processInstance = processInstance;
    }

    public CreditApplicationResponse getCreditApplication() {
        return creditApplication;
    }

    public void setCreditApplication(CreditApplicationResponse creditApplication) {
        this.creditApplication = creditApplication;
    }

    public UpdateAmountResponse getUpdateAmounts() {
        return updateAmounts;
    }

    public void setUpdateAmounts(UpdateAmountResponse updateAmounts) {
        this.updateAmounts = updateAmounts;
    }

    public GenericResponse getEvaluatePolitics() {
        return evaluatePolitics;
    }

    public void setEvaluatePolitics(GenericResponse evaluatePolitics) {
        this.evaluatePolitics = evaluatePolitics;
    }

    public GenericResponse getCompleteTask() {
        return completeTask;
    }

    public void setCompleteTask(GenericResponse completeTask) {
        this.completeTask = completeTask;
    }
}
