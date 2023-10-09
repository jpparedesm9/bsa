package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * Created by ntrujillo on 17/07/2017.
 */
public class CreditApplicationResponse {

	ServiceResponse processInstance;
	ServiceResponse creditApplication;
	ServiceResponse updateAmounts;
	ServiceResponse evaluatePolitics;
	ServiceResponse completeTask;
	ServiceResponse observations;
	ServiceResponse buro;

	public ServiceResponse getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(ServiceResponse processInstance) {
		this.processInstance = processInstance;
	}

	public ServiceResponse getCreditApplication() {
		return creditApplication;
	}

	public void setCreditApplication(ServiceResponse creditApplication) {
		this.creditApplication = creditApplication;
	}

	public ServiceResponse getEvaluatePolitics() {
		return evaluatePolitics;
	}

	public void setEvaluatePolitics(ServiceResponse evaluatePolitics) {
		this.evaluatePolitics = evaluatePolitics;
	}

	public ServiceResponse getCompleteTask() {
		return completeTask;
	}

	public void setCompleteTask(ServiceResponse completeTask) {
		this.completeTask = completeTask;
	}

	public ServiceResponse getUpdateAmounts() {
		return updateAmounts;
	}

	public void setUpdateAmounts(ServiceResponse updateAmounts) {
		this.updateAmounts = updateAmounts;
	}

	public ServiceResponse getObservations() {
		return observations;
	}

	public void setObservations(ServiceResponse observations) {
		this.observations = observations;
	}

	public ServiceResponse getBuro() {
		return buro;
	}

	public void setBuro(ServiceResponse buro) {
		this.buro = buro;
	}

}
