/*
 * File: Company.java
 * Date: March 08, 2012
 *
 * Copyright (c) 2011 Cobiscorp (Banking Technology Partners) SA, All Rights Reserved.
 *
 * This code is confidential to Cobiscorp and shall not be disclosed outside Cobiscorp                                      
 * without the prior written permission of the Technology Center.
 *
 * In the event that such disclosure is permitted the code shall not be copied
 * or distributed other than on a need-to-know basis and any recipients may be
 * required to sign a confidentiality undertaking in favor of Cobiscorp SA.
 */

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

/**
 * OperationDef Entity - The persistent class for the   ca_operacion table into cob_cartera database
 * 
 * @author aguachichulca
 */
@Entity
@Table(name="ca_operacion",schema="cob_cartera")
@NamedQueries({@NamedQuery(name="Operation.FindSpecificOperation",query="Select op from Operation op where op.operation =: operation "),
	@NamedQuery(name = "Operation.FindCodeOperation", query = "Select op.operation from Operation op where op.tOperation =: tOperation"),
	@NamedQuery(name = "Operation.FindOperationByBankId", query = "Select op from Operation op where op.bank=: bank")})

public class Operation {
	/** operation id */
	@Id
	@Column(name="op_operacion")
	private int operation;
	
	/** op_toperacion */
	@Column(name="op_toperacion")
	private String tOperation;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "op_fecha_ini")
	private Date initialDate;
	
	@Column(name = "op_sector")
	private String sector;
	
	@Column(name = "op_moneda")
	private Long currency; 

	@Column(name = "op_banco")
	private String bank;
	
	@Column(name = "op_estado")
	private int state;

	public Operation() {
		
	}

	public Operation(int operation, String tOperation) {
		super();
		this.operation = operation;
		this.tOperation = tOperation;
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
		Operation other = (Operation) obj;
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
		return "Operation [operation=" + operation + ", tOperation="
				+ tOperation + ", initialDate=" + initialDate + ", sector="
				+ sector + ", currency=" + currency + ", bank=" + bank
				+ ", state=" + state + "]";
	}
}
