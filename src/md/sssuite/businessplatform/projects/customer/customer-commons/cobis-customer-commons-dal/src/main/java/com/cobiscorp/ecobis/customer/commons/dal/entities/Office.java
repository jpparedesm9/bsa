package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "cl_oficina", schema = "cobis")
/**
 * Class used to access the database using JPA
 * related table: cl_oficina bdd: cobis
 * @author bbuendia
 *
 */
public class Office {

	@Id
	@Column (name = "of_oficina")
	private Integer idOffice;
	
	@Column (name = "of_nombre")
	private String officeName;
	
	@OneToMany(mappedBy = "office")
	private List<CustomerAddress> customerAddress;
	
	public Office()
	{
		
	}
	
	public Office(Integer idOffice, String officeName)
	{
		this.idOffice=idOffice;
		this.officeName=officeName;
	}
	
	public Integer getIdOffice()
	{
		return idOffice;
	}
	
	public void setIdOffice(Integer idOffice)
	{
		this.idOffice=idOffice;
	}
	
	public String getOffcieName()
	{
		return officeName;
	}
	
	public void setOfficeName(String officeName)
	{
		this.officeName=officeName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idOffice == null) ? 0 : idOffice.hashCode());
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
		Office other = (Office) obj;
		if (idOffice == null) {
			if (other.idOffice != null)
				return false;
		} else if (!idOffice.equals(other.idOffice))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Office [idOffice=" + idOffice + ", officeName=" + officeName
				+ ", customerAddress=" + customerAddress + "]";
	}


	
}
