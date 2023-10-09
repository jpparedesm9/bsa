package com.cobiscorp.ecobis.fpm.portfolio.model;

public class ItemsOperationPortfolioIdDef {

	private int operation;
	private String concept;
	
	public ItemsOperationPortfolioIdDef() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ItemsOperationPortfolioIdDef(int operation, String concept) {
		super();
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((concept == null) ? 0 : concept.hashCode());
		result = prime * result + operation;
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
		ItemsOperationPortfolioIdDef other = (ItemsOperationPortfolioIdDef) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
		if (operation != other.operation)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ItemsOperationPortfolioIdDef [operation=" + operation
				+ ", concept=" + concept + "]";
	}
	
	
	
	
	
	
	
}
