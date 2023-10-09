package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.io.Serializable;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "di_ente" and "di_direccion"
 * from the table: cl_direccion
 * @author bbuendia
 *
 */
@Embeddable
public class CustomerAddressId implements Serializable {
	
	private Integer idClient;
	private Integer idDirection;
	
	public CustomerAddressId(){
				
	}
	
	public CustomerAddressId(Integer idClient, Integer idDirection)
	{
		this.idClient=idClient;
		this.idDirection=idDirection;
		
	}
	
	public Integer getIdClient()
	{
		return idClient;
	}
	
	public void setIdClient(Integer idClient)
	{
		this.idClient=idClient;		
	}
	
	public Integer getIdDirection()
	{
		return idDirection;
	}
	
	public void setIdDirection(Integer idDirection)
	{
		this.idDirection=idDirection;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idClient == null) ? 0 : idClient.hashCode());
		result = prime * result
				+ ((idDirection == null) ? 0 : idDirection.hashCode());
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
		CustomerAddressId other = (CustomerAddressId) obj;
		if (idClient == null) {
			if (other.idClient != null)
				return false;
		} else if (!idClient.equals(other.idClient))
			return false;
		if (idDirection == null) {
			if (other.idDirection != null)
				return false;
		} else if (!idDirection.equals(other.idDirection))
			return false;
		return true;
	}	
	
}
