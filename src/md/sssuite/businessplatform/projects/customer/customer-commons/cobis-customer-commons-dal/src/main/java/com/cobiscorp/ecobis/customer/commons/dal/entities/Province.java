package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "cl_provincia", schema = "cobis")

/**
 * Class used to access the database using JPA
 * related table: cl_provincia, bdd: cobis
 * @author bbuendia
 *
 */
public class Province {

	@Id
	@Column (name = "pv_provincia")
	private Integer idProvince;
	
	@Column (name = "pv_descripcion")
	private String descriptionProvince;
	
	@OneToMany(mappedBy = "province")
	private List<CustomerAddress> customerAddress;
	
	public Province(){
		
	}
	
	public Province(Integer idProvince,String descriptionPorovince){
		this.idProvince=idProvince;
		this.descriptionProvince=descriptionPorovince;
		
	}
	
	public Integer getIdProvince()
	{
		return idProvince;
	}
	
	public void setIdProvince(Integer idProvince)
	{
		this.idProvince=idProvince;
	}
	
	public String getDescriptionProvince()
	{
		return descriptionProvince;
	}
	
	public void setDescriptionProvince(String descriptionProvince)
	{
		this.descriptionProvince=descriptionProvince;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idProvince == null) ? 0 : idProvince.hashCode());
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
		Province other = (Province) obj;
		if (idProvince == null) {
			if (other.idProvince != null)
				return false;
		} else if (!idProvince.equals(other.idProvince))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Province [idProvince=" + idProvince + ", descriptionProvince="
				+ descriptionProvince + ", customerAddress=" + customerAddress
				+ "]";
	}


	
	
}
