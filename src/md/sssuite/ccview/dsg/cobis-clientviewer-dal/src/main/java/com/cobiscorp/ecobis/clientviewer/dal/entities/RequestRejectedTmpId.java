package com.cobiscorp.ecobis.clientviewer.dal.entities;


public class RequestRejectedTmpId {

	private Integer spidReqReject;
	private String numberIdentifier;
	private String operationNumber;

	public RequestRejectedTmpId() {
		super();
	}
	
	public Integer getSpidReqReject() {
		return spidReqReject;
	}
	public void setSpidReqReject(Integer spidReqReject) {
		this.spidReqReject = spidReqReject;
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((numberIdentifier == null) ? 0 : numberIdentifier.hashCode());
		result = prime * result + ((operationNumber == null) ? 0 : operationNumber.hashCode());
		result = prime * result + ((spidReqReject == null) ? 0 : spidReqReject.hashCode());
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
		RequestRejectedTmpId other = (RequestRejectedTmpId) obj;
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
		if (spidReqReject == null) {
			if (other.spidReqReject != null)
				return false;
		} else if (!spidReqReject.equals(other.spidReqReject))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "RequestRejectedTmpId [spidReqReject=" + spidReqReject + ", numberIdentifier=" + numberIdentifier + ", operationNumber=" + operationNumber + "]";
	}
}
