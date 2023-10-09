package com.cobiscorp.ecobis.fpm.portfolio.model;


public class CreditLineOperationCurrencyId {

	private int line;
	private String product;
	private String purpose;
	private int currency;
	
	public CreditLineOperationCurrencyId(int line, String product,
			String purpose, int currency) {
		this.line = line;
		this.product = product;
		this.purpose = purpose;
		this.currency = currency;
	}

	public CreditLineOperationCurrencyId() {
	}

	public int getLine() {
		return line;
	}

	public void setLine(int line) {
		this.line = line;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public int getCurrency() {
		return currency;
	}

	public void setCurrency(int currency) {
		this.currency = currency;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + currency;
		result = prime * result + line;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((purpose == null) ? 0 : purpose.hashCode());
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
		CreditLineOperationCurrencyId other = (CreditLineOperationCurrencyId) obj;
		if (currency != other.currency)
			return false;
		if (line != other.line)
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (purpose == null) {
			if (other.purpose != null)
				return false;
		} else if (!purpose.equals(other.purpose))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CreditLineOperationCurrencyId [line=" + line + ", product="
				+ product + ", purpose=" + purpose + ", currency=" + currency
				+ "]";
	}
	
}
