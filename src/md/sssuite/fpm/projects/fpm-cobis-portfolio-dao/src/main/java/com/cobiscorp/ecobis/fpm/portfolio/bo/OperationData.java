package com.cobiscorp.ecobis.fpm.portfolio.bo;

import java.util.Date;

public class OperationData {

	private int operation;
	private String tOperation;
	private Date initialDate;
	private String sector;
	private Long currency; 
	private String bank;
	private int state;
	
	public OperationData(int operation, String tOperation, Date initialDate,
			String sector, Long currency, String bank, int state) {
		super();
		this.operation = operation;
		this.tOperation = tOperation;
		this.initialDate = initialDate;
		this.sector = sector;
		this.currency = currency;
		this.bank = bank;
		this.state = state;
	}
	
	public OperationData() {
	}

	public int getOperation() {
		return operation;
	}
	public void setOperation(int operation) {
		this.operation = operation;
	}
	public String gettOperation() {
		return tOperation;
	}
	public void settOperation(String tOperation) {
		this.tOperation = tOperation;
	}
	public Date getInitialDate() {
		return initialDate;
	}
	public void setInitialDate(Date initialDate) {
		this.initialDate = initialDate;
	}
	public String getSector() {
		return sector;
	}
	public void setSector(String sector) {
		this.sector = sector;
	}
	public Long getCurrency() {
		return currency;
	}
	public void setCurrency(Long currency) {
		this.currency = currency;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((currency == null) ? 0 : currency.hashCode());
		result = prime * result + operation;
		result = prime * result
				+ ((tOperation == null) ? 0 : tOperation.hashCode());
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
		OperationData other = (OperationData) obj;
		if (currency == null) {
			if (other.currency != null)
				return false;
		} else if (!currency.equals(other.currency))
			return false;
		if (operation != other.operation)
			return false;
		if (tOperation == null) {
			if (other.tOperation != null)
				return false;
		} else if (!tOperation.equals(other.tOperation))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "OperationData [operation=" + operation + ", tOperation="
				+ tOperation + ", initialDate=" + initialDate + ", sector="
				+ sector + ", currency=" + currency + ", bank=" + bank
				+ ", state=" + state + "]";
	}

}
