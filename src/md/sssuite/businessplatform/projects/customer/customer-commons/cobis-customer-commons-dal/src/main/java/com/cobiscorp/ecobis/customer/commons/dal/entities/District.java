package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table (name = "cl_parroquia", schema = "cobis")

/**
 * Class used to access the database using JPA
 * related table: cl_parroquia, bdd: cobis
 * @author bbuendia
 *
 */
public class District {

	@Id
	@Column (name = "pq_parroquia")
	private Integer idDistrict;
	
	@Column (name = "pq_descripcion")
	private String descriptionDistrict;
	
	@Column (name = "pq_ciudad")
	private Integer idCity;
	
	@OneToMany(mappedBy = "district")
	private List<CustomerAddress> customerAddress;
	
	public District()
	{
		
	}
	
	public District (Integer idDistrict, String descriptionDistrict, Integer idCity)
	{
		this.idDistrict=idDistrict;
		this.descriptionDistrict=descriptionDistrict;
		this.idCity=idCity;
	}
	
	public Integer getIdDistrict()
	{
		return idDistrict;
	}
	
	public void setIdDistrict(Integer idDistrict)
	{
		this.idDistrict=idDistrict;
	}
	
	public String getDescriptionDistrict()
	{
		return descriptionDistrict;
	}
	
	public void setDescriptionDistrict(String descriptionDistrict)
	{
		this.descriptionDistrict=descriptionDistrict;
	}
	
	public Integer getIdCity()
	{
		return idCity;
	}
	
	public void setIdCity(Integer idCity)
	{
		this.idCity=idCity;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idDistrict == null) ? 0 : idDistrict.hashCode());
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
		District other = (District) obj;
		if (idDistrict == null) {
			if (other.idDistrict != null)
				return false;
		} else if (!idDistrict.equals(other.idDistrict))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "District [idDistrict=" + idDistrict + ", descriptionDistrict="
				+ descriptionDistrict + ", idCity=" + idCity
				+ ", customerAddress=" + customerAddress + "]";
	}

	


	
	
}
