package com.cobiscorp.ecobis.customer.dal.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

public class PhonePk implements Serializable  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "te_ente")
	private Integer entity;
	
	@Id
	@Column(name = "te_direccion")
	private Integer address; 

	@Id
	@Column(name = "te_secuencial")
	private Integer sequential;

	public Integer getEntity() {
		return entity;
	}

	public void setEntity(Integer entity) {
		this.entity = entity;
	}

	public Integer getAddress() {
		return address;
	}

	public void setAddress(Integer address) {
		this.address = address;
	}

	public Integer getSequential() {
		return sequential;
	}

	public void setSequential(Integer sequential) {
		this.sequential = sequential;
	} 
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((entity == null) ? 0 : entity.hashCode());
		result = prime * result
				+ ((address == null) ? 0 : address.hashCode());
		result = prime * result
				+ ((sequential == null) ? 0 : sequential.hashCode());
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
		PhonePk other = (PhonePk) obj;
		if (entity == null) {
			if (other.entity != null)
				return false;
		} else if (!entity.equals(other.entity))
			return false;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (sequential == null) {
			if (other.sequential != null)
				return false;
		} else if (!sequential.equals(other.sequential))
			return false;
		return true;
	}

	
    
	
	
	
	

}
