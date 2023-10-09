package com.cobiscorp.mobile.model;

public class NotificationRequest {

	private String sendingSource;
	private String sendingType;

	public String getSendingSource() {
		return sendingSource;
	}

	public void setSendingSource(String sendingSource) {
		this.sendingSource = sendingSource;
	}

	public String getSendingType() {
		return sendingType;
	}

	public void setSendingType(String sendingType) {
		this.sendingType = sendingType;
	}

	@Override
	public String toString() {
		return "NotificationRequest [sendingSource=" + sendingSource + ", sendingType=" + sendingType + "]";
	}
	
	

}
