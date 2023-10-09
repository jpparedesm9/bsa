package com.cobiscorp.mobile.response;

import java.math.BigDecimal;

public class CustomerEvaluationResponse {

	private int customerId;
	private boolean evaluation;
	private String qualification;
	private Double amountApproved;

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public boolean isEvaluation() {
		return evaluation;
	}

	public void setEvaluation(boolean evaluation) {
		this.evaluation = evaluation;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public Double getAmountApproved() {
		return amountApproved;
	}

	public void setAmountApproved(Double amountApproved) {
		this.amountApproved = amountApproved;
	}

	@Override
	public String toString() {
		return "CustomerEvaluationResponse [customerId=" + customerId + ", evaluation=" + evaluation
				+ ", qualification=" + qualification + ", amountApproved=" + amountApproved + "]";
	}

}
