package com.cobiscorp.ecobis.frm.business.dto;

import java.util.List;

public class FormAnswers {
	private Integer customerId;
	private Integer formId;
	private Integer formVersion;
	private Integer processInstance;
	private List<AnswerData> answerData;

	public Integer getFormId() {
		return formId;
	}

	public void setFormId(Integer formId) {
		this.formId = formId;
	}

	public Integer getFormVersion() {
		return formVersion;
	}

	public void setFormVersion(Integer formVersion) {
		this.formVersion = formVersion;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public List<AnswerData> getAnswerData() {
		return answerData;
	}

	public void setAnswerData(List<AnswerData> answerData) {
		this.answerData = answerData;
	}

	public Integer getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(Integer processInstance) {
		this.processInstance = processInstance;
	}
	
	

}
