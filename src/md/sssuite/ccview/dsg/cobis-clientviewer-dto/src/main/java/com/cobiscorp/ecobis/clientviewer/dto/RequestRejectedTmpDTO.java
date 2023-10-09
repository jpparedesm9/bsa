package com.cobiscorp.ecobis.clientviewer.dto;

public class RequestRejectedTmpDTO {

	private String numberIdentifier;
	private String operationNumber;
	private String dateLoad;
	private String dateRejected;
	private String reason;
	private String user;
	private String module;
	
	public RequestRejectedTmpDTO() {
		super();
	}

	public RequestRejectedTmpDTO(String numberIdentifier,
			String operationNumber, String dateLoad, String dateRejected,
			String reason, String user, String module) {
		super();
		this.numberIdentifier = numberIdentifier;
		this.operationNumber = operationNumber;
		this.dateLoad = dateLoad;
		this.dateRejected = dateRejected;
		this.reason = reason;
		this.user = user;
		this.module = module;
	}

	public String getNumberIdentifier() {
		return numberIdentifier;
	}

	public void setNumberIdentifier(String numberIdentifier) {
		this.numberIdentifier = numberIdentifier;
	}

	public String getOperationNumber() {
		return operationNumber;
	}

	public void setOperationNumber(String operationNumber) {
		this.operationNumber = operationNumber;
	}

	public String getDateLoad() {
		return dateLoad;
	}

	public void setDateLoad(String dateLoad) {
		this.dateLoad = dateLoad;
	}

	public String getDateRejected() {
		return dateRejected;
	}

	public void setDateRejected(String dateRejected) {
		this.dateRejected = dateRejected;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}
	
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime
				* result
				+ ((numberIdentifier == null) ? 0 : numberIdentifier.hashCode());
		result = prime * result
				+ ((operationNumber == null) ? 0 : operationNumber.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RequestRejectedTmpDTO other = (RequestRejectedTmpDTO) obj;
		if (numberIdentifier == null) {
			if (other.numberIdentifier != null)
				return false;
		} else if (!numberIdentifier.equals(other.numberIdentifier))
			return false;
		if (operationNumber == null) {
			if (other.operationNumber != null)
				return false;
		} else if (!operationNumber.equals(other.operationNumber))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "RequestRejectedTmpDTO [numberIdentifier=" + numberIdentifier
				+ ", operationNumber=" + operationNumber + ", dateLoad="
				+ dateLoad + ", dateRejected=" + dateRejected + ", reason="
				+ reason + ", user=" + user + ", module=" + module + "]";
	}
}
