package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.io.Serializable;

public class ItemsOperationPortfolioId implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int operation;
	private String concept;

	public ItemsOperationPortfolioId() {
	}

	public ItemsOperationPortfolioId(int operation, String concept) {
		this.operation = operation;
		this.concept = concept;
	}

	public int getOperation() {
		return operation;
	}

	public void setOperation(int operation) {
		this.operation = operation;
	}

	public String getConcept() {
		return concept;
	}

	public void setConcept(String concept) {
		this.concept = concept;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((concept == null) ? 0 : concept.hashCode());
		result = prime * result + operation;
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItemsOperationPortfolioId other = (ItemsOperationPortfolioId) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
		if (operation != other.operation)
			return false;
		return true;
	}

	public String toString() {
		return "ItemsOperationPortfolioId [operation=" + operation
				+ ", concept=" + concept + "]";
	}
}
