package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "cr_lin_ope_moneda", schema = "cob_credito")
@IdClass(CreditLineOperationCurrencyId.class)
@NamedQueries({ @NamedQuery(name = "CreditLineOperationCurrency.Find", query = "select clopc from CreditLineOperationCurrency clopc where clopc.line = :line and clopc.operation = :operation and clopc.product = :product and clopc.purpose = :purpose and clopc.currency = :currency") })
public class CreditLineOperationCurrency {

	@Id
	@Column(name = "om_linea")
	private int line;

	@Column(name = "om_toperacion")
	private String operation;

	@Id
	@Column(name = "om_producto")
	private String product;

	@Id
	@Column(name = "om_proposito_op")
	private String purpose;

	@Id
	@Column(name = "om_moneda")
	private int currency;

	public CreditLineOperationCurrency(int line, String operation,
			String product, String purpose, int currency) {
		this.line = line;
		this.operation = operation;
		this.product = product;
		this.purpose = purpose;
		this.currency = currency;
	}

	public CreditLineOperationCurrency() {
	}

	public int getLine() {
		return line;
	}

	public void setLine(int line) {
		this.line = line;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
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
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
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
		CreditLineOperationCurrency other = (CreditLineOperationCurrency) obj;
		if (currency != other.currency)
			return false;
		if (line != other.line)
			return false;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
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
		return "CreditLineOperationCurrency [line=" + line + ", operation="
				+ operation + ", product=" + product + ", purpose=" + purpose
				+ ", currency=" + currency + "]";
	}

}
