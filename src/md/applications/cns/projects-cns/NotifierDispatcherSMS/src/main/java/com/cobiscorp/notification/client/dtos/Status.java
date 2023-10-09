package com.cobiscorp.notification.client.dtos;

public class Status {
	private String statusCode;
	private String serverStatusCode;
	private String severity;
	private String statusDesc;
	private AdditionalStatus additionalStatus;

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getServerStatusCode() {
		return serverStatusCode;
	}

	public void setServerStatusCode(String serverStatusCode) {
		this.serverStatusCode = serverStatusCode;
	}

	public String getSeverity() {
		return severity;
	}

	public void setSeverity(String severity) {
		this.severity = severity;
	}

	public String getStatusDesc() {
		return statusDesc;
	}

	public void setStatusDesc(String statusDesc) {
		this.statusDesc = statusDesc;
	}

	public AdditionalStatus getAdditionalStatus() {
		return additionalStatus;
	}

	public void setAdditionalStatus(AdditionalStatus additionalStatus) {
		this.additionalStatus = additionalStatus;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Status [statusCode=");
		builder.append(statusCode);
		builder.append(", serverStatusCode=");
		builder.append(serverStatusCode);
		builder.append(", severity=");
		builder.append(severity);
		builder.append(", statusDesc=");
		builder.append(statusDesc);
		builder.append(", additionalStatus=");
		builder.append(additionalStatus);
		builder.append("]");
		return builder.toString();
	}

}
