package com.cobiscorp.mobile.request;

public class BeneficiaryLifeInsuranceRequest {

	private String id;
	private String beneficiaryName;
	private int relationshipId;
	private double percentage;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
	public String getBeneficiaryName() {
		return beneficiaryName;
	}

	public void setBeneficiaryName(String beneficiaryName) {
		this.beneficiaryName = beneficiaryName;
	}



	public int getRelationshipId() {
		return relationshipId;
	}

	public void setRelationshipId(int relationshipId) {
		this.relationshipId = relationshipId;
	}

	public double getPercentage() {
		return percentage;
	}

	public void setPercentage(double percentage) {
		this.percentage = percentage;
	}

	@Override
	public String toString() {
		return "BeneficiaryLifeInsuranceRequest [id=" + id + ", beneficiaryName=" + beneficiaryName + ", relationshipId=" + relationshipId
				+ ", percentage=" + percentage + "]";
	}

}
