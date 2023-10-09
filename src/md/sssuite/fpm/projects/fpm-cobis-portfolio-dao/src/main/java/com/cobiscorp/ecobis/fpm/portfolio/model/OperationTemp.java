package com.cobiscorp.ecobis.fpm.portfolio.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "ca_operacion_tmp", schema = "cob_cartera")
@NamedQueries({
	@NamedQuery(name = "OperationTemp.FindAll", query = "Select op from OperationTemp op"),
	@NamedQuery(name = "OperationTemp.FindCodeOperation", query = "Select op.operation from OperationTemp op where op.tOperation =: tOperation"),
	@NamedQuery(name = "OperationTemp.FindSpecificOperation", query = "Select op from OperationTemp op where op.operation =: operation"),
	@NamedQuery(name = "OperationTemp.FindOperationByBankId", query = "Select op from OperationTemp op where op.bank=: bank")})
public class OperationTemp {
	
	@Id
	@Column(name = "opt_operacion")
	private int operation;
	
	@Column(name = "opt_toperacion")
	private String tOperation;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "opt_fecha_ini")
	private Date initialDate;
	
	@Column(name = "opt_sector")
	private String sector;
	
	@Column(name = "opt_moneda")
	private Long currency; 

	@Column(name = "opt_banco")
	private String bank;
	
	@Column(name = "opt_estado")
	private int state;

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
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
	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	
	public OperationTemp() {
	}
	
	public OperationTemp(int operation, String tOperation) {
		super();
		this.operation = operation;
		this.tOperation = tOperation;
	}
	
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + operation;
		result = prime * result
				+ ((tOperation == null) ? 0 : tOperation.hashCode());
		return result;
	}
	
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OperationTemp other = (OperationTemp) obj;
		if (operation != other.operation)
			return false;
		if (tOperation == null) {
			if (other.tOperation != null)
				return false;
		} else if (!tOperation.equals(other.tOperation))
			return false;
		return true;
	}
	
	public String toString() {
		return "OperationTemp [operation=" + operation + ", tOperation="
				+ tOperation + "]";
	}
}
