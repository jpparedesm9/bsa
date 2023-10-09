package com.cobiscorp.mobile.model;

import java.util.ArrayList;
import java.util.List;

public class KYCFormRequestLocal extends BaseRequest {

	private Integer clientId;
	private QuestionKYC[] questions;
	private String accept;

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}



	public QuestionKYC[] getQuestions() {
		return questions;
	}

	public void setQuestions(QuestionKYC[] questions) {
		this.questions = questions;
	}

	public String getAccept() {
		return accept;
	}

	public void setAccept(String accept) {
		this.accept = accept;
	}

	@Override
	public String toString() {
		return "KYCFormRequestLocal [clientId=" + clientId + ", questions=" + questions + ", accept=" + accept + "]";
	}

}
