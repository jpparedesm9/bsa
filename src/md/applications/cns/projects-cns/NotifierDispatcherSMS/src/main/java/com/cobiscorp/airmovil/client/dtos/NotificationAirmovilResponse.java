package com.cobiscorp.airmovil.client.dtos;

public class NotificationAirmovilResponse {

	private String timestamp;
	private String message;
	private int status;
	private String idNotification;

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getIdNotification() {
		return idNotification;
	}

	public void setIdNotification(String idNotification) {
		this.idNotification = idNotification;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("NotificationAirmovilResponse [timestamp=");
		builder.append(timestamp);
		builder.append(", message=");
		builder.append(message);
		builder.append(", status=");
		builder.append(status);
		builder.append(", idNotification=");
		builder.append(idNotification);
		builder.append("]");
		return builder.toString();
	}

}
