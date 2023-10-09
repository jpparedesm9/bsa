/*
 * File: CreditOperationId.java
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

/**
 * The identifier class for the <tt>CreditOperation</tt> entity
 * 
 * @author cloachamin
 */
public class CreditOperationId {

	private String operationCode;
	private String product;

	public CreditOperationId() { }
	
	public CreditOperationId(String operationCode, String product) {
		this.operationCode = operationCode;
		this.product = product;
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
		CreditOperationId other = (CreditOperationId) obj;
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
		return "CreditOperationId [operationCode=" + operationCode
				+ ", product=" + product + "]";
	}

}
