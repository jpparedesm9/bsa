package com.cobiscorp.notification.client.dtos;

public class NotificationResponse {
	private Status status;
	private String rqUID;

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getRqUID() {
		return rqUID;
	}

	public void setRqUID(String rqUID) {
		this.rqUID = rqUID;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("NotificationResponse [status=");
		builder.append(status);
		builder.append(", rqUID=");
		builder.append(rqUID);
		builder.append("]");
		return builder.toString();
	}

}
