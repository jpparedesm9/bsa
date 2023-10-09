package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.io.Serializable;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "prd_id" and "pr_rol_id"
 * from the table: cl_cliente_grupo
 * @author bbuendia
 *
 */
@Embeddable
public class CustomerGroupId implements Serializable {

	private Integer customerCode;
	private Integer groupCode;

	public CustomerGroupId() {
	}

	public CustomerGroupId(Integer customerCode, Integer groupCode) {
		this.customerCode = customerCode;
		this.groupCode = groupCode;
	}

	public Integer getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(Integer customerCode) {
		this.customerCode = customerCode;
	}

	public Integer getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(Integer groupCode) {
		this.groupCode = groupCode;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((customerCode == null) ? 0 : customerCode.hashCode());
		result = prime * result
				+ ((groupCode == null) ? 0 : groupCode.hashCode());
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
		CustomerGroupId other = (CustomerGroupId) obj;
		if (customerCode == null) {
			if (other.customerCode != null)
				return false;
		} else if (!customerCode.equals(other.customerCode))
			return false;
		if (groupCode == null) {
			if (other.groupCode != null)
				return false;
		} else if (!groupCode.equals(other.groupCode))
			return false;
		return true;
	}	

}
