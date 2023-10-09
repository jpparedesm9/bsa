package com.cobiscorp.ecobis.cloud.service.dto.group;

public class GroupValidation {
	private int groupId;
	private boolean availableForCredit;
	private String requestType;

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public boolean isAvailableForCredit() {
		return availableForCredit;
	}

	public void setAvailableForCredit(boolean availableForCredit) {
		this.availableForCredit = availableForCredit;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String applicationType) {
		this.requestType = applicationType;
	}

}
