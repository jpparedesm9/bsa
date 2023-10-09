package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.io.Serializable;

public class TranOperationId implements Serializable {

	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 1L;

	/** Banking Product Id. */
	private String operation;

	/** Transaction Type Id. */
	private String type;

	/** Filial Id. */
	private Integer filial;

	/**
	 * Default Constructor
	 */
	public TranOperationId() {
	}

	/**
	 * Constructor
	 * 
	 * @param operation
	 * @param type
	 * @param filial
	 */
	public TranOperationId(String operation, String type, Integer filial) {
		this.operation = operation;
		this.type = type;
		this.filial = filial;
	}

	/**
	 * @return the operation
	 */
	public String getOperation() {
		return operation;
	}

	/**
	 * @param operation
	 *            the operation to set
	 */
	public void setOperation(String operation) {
		this.operation = operation;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the filial
	 */
	public Integer getFilial() {
		return filial;
	}

	/**
	 * @param filial
	 *            the filial to set
	 */
	public void setFilial(Integer filial) {
		this.filial = filial;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((filial == null) ? 0 : filial.hashCode());
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		TranOperationId other = (TranOperationId) obj;
		if (filial == null) {
			if (other.filial != null)
				return false;
		} else if (!filial.equals(other.filial))
			return false;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	public String toString() {
		return "TranOperationId [operation=" + operation + ", type=" + type
				+ ", filial=" + filial + "]";
	}
}
