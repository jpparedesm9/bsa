package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.io.Serializable;

public class DefaultOperationId implements Serializable{

	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 1L;
	
	private String operation;
	private long currency;
	
	public DefaultOperationId(String operation, long currency) {
		this.operation = operation;
		this.currency = currency;
	}

	public DefaultOperationId() {
		
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public long getCurrency() {
		return currency;
	}

	public void setCurrency(long currency) {
		this.currency = currency;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (currency ^ (currency >>> 32));
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DefaultOperationId other = (DefaultOperationId) obj;
		if (currency != other.currency)
			return false;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		return true;
	}

	public String toString() {
		return "DefaultOperationId [operation=" + operation + ", currency="
				+ currency + "]";
	}
}
