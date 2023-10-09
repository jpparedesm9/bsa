package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.io.Serializable;

public class ItemsPortfolioId implements Serializable {

	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 1L;
	
	private String operation;
	private long currency;
	private String concept;
	
	public ItemsPortfolioId() {
	}

	public ItemsPortfolioId(String operation, long currency, String concept) {
		this.operation = operation;
		this.currency = currency;
		this.concept = concept;
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
		ItemsPortfolioId other = (ItemsPortfolioId) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
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
		return "ItemsPortfolioId [operation=" + operation + ", currency="
				+ currency + ", concept=" + concept + "]";
	}  
	
	
	
	

}
