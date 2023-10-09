package com.cobiscorp.ecobis.assets.dto;

public class SolidarityPaymentCustomerData {
	private Integer groupId;
	private Character affectsSavings;
	private Double amount;
	private String paymentsDetail;

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Character getAffectsSavings() {
		return affectsSavings;
	}

	public void setAffectsSavings(Character affectsSavings) {
		this.affectsSavings = affectsSavings;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getPaymentsDetail() {
		return paymentsDetail;
	}

	public void setPaymentsDetail(String paymentsDetail) {
		this.paymentsDetail = paymentsDetail;
	}

}
