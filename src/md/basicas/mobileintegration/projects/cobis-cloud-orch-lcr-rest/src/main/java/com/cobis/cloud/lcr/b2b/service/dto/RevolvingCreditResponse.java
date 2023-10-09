package com.cobis.cloud.lcr.b2b.service.dto;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class RevolvingCreditResponse {
	ServiceResponse processInstance; // crear la instancia de proceso
	ServiceResponse creditApplication; // crear el trámite
	ServiceResponse completeTask; // pasar a la siguiente actividad
	ServiceResponse evaluatePolitics; // politicas

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

	public ServiceResponse getCompleteTask() {
		return completeTask;
	}

	public void setCompleteTask(ServiceResponse completeTask) {
		this.completeTask = completeTask;
	}

	public ServiceResponse getEvaluatePolitics() {
		return evaluatePolitics;
	}

	public void setEvaluatePolitics(ServiceResponse evaluatePolitics) {
		this.evaluatePolitics = evaluatePolitics;
	}

}
