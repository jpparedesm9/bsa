package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="cr_linea",schema="cob_credito")

@NamedQueries({
	@NamedQuery(name="CreditLine.FindLine", query="Select cl.number from CreditLine cl where cl.numberBank = :lineNumberBank")
})
public class CreditLine {

	@Id
	@Column(name = "li_numero")
	private int number;

	@Column(name = "li_num_banco")
	private String numberBank;

	public CreditLine(int number, String numberBank) {
		this.number = number;
		this.numberBank = numberBank;
	}

	public CreditLine() {
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getNumberBank() {
		return numberBank;
	}

	public void setNumberBank(String numberBank) {
		this.numberBank = numberBank;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + number;
		result = prime * result
				+ ((numberBank == null) ? 0 : numberBank.hashCode());
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
		CreditLine other = (CreditLine) obj;
		if (number != other.number)
			return false;
		if (numberBank == null) {
			if (other.numberBank != null)
				return false;
		} else if (!numberBank.equals(other.numberBank))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CreditLine [number=" + number + ", numberBank=" + numberBank
				+ "]";
	}
}
