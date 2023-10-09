package com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto;

public class CustomerEvaluationResponse {

	private int customerId;
	private boolean problemBuro;
	private String qualification;
	private String blackList;
	private String riskLevel;
	private Double amountApproved;
	private boolean evaluation;
	private String colorMessage;

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public boolean isProblemBuro() {
		return problemBuro;
	}

	public void setProblemBuro(boolean problemBuro) {
		this.problemBuro = problemBuro;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public String getBlackList() {
		return blackList;
	}

	public void setBlackList(String blackList) {
		this.blackList = blackList;
	}

	public String getRiskLevel() {
		return riskLevel;
	}

	public void setRiskLevel(String riskLevel) {
		this.riskLevel = riskLevel;
	}

	public Double getAmountApproved() {
		return amountApproved;
	}

	public void setAmountApproved(Double amountApproved) {
		this.amountApproved = amountApproved;
	}

	public boolean isEvaluation() {
		return evaluation;
	}

	public void setEvaluation(boolean evaluation) {
		this.evaluation = evaluation;
	}
	
	public String getColorMessage() {
		return colorMessage;
	}

	public void setColorMessage(String colorMessage) {
		this.colorMessage = colorMessage;
	}

	@Override
	public String toString() {
		return "CustomerEvaluationResponse [customerId=" + customerId + ", problemBuro=" + problemBuro + ", qualification=" + qualification + ", blackList=" + blackList
				+ ", riskLevel=" + riskLevel + ", amountApproved=" + amountApproved + ", evaluation=" + evaluation + ", colorMessage=" + colorMessage + "]";
	}

}
