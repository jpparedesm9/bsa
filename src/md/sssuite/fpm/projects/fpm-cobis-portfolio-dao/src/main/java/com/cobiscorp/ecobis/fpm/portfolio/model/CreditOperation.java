/*
 * File: CreditOperation.java
 * Date: June 04, 2012
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
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="cr_toperacion",schema="cob_credito")
@IdClass(CreditOperationId.class)
public class CreditOperation {

	@Id
	@Column(name = "to_toperacion")
	private String operationCode;
	@Id
	@Column(name = "to_producto")
	private String product;
	@Column(name = "to_descripcion")
	private String description;
	@Column(name = "to_estado")
	private String status;
	@Column(name = "to_fecha_cambio")
	@Temporal(TemporalType.TIMESTAMP)
	private Date modificationDate;
	
	public CreditOperation () {}
	
	public CreditOperation(String operationCode) {		
		this.operationCode = operationCode;
	}

	public String getOperationCode() {
		return operationCode;
	}

	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getModificationDate() {
		return modificationDate;
	}

	public void setModificationDate(Date modificationDate) {
		this.modificationDate = modificationDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((operationCode == null) ? 0 : operationCode.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
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
		CreditOperation other = (CreditOperation) obj;
		if (operationCode == null) {
			if (other.operationCode != null)
				return false;
		} else if (!operationCode.equals(other.operationCode))
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CreditOperation [operationCode=" + operationCode + ", product="
				+ product + ", description=" + description + ", status="
				+ status + ", modificationDate=" + modificationDate + "]";
	}
	
}
