package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table (name = "cl_barrio", schema = "cobis")

/**
 * Class used to access the database using JPA
 * related table: cl_barrio, bdd: cobis
 * @author bbuendia
 *
 */
public class Town {
	
	@Id
	@Column (name = "ba_barrio")
	private Integer idTown;
	
	@Column (name = "ba_descripcion")
	private String descriptionTown;
	
	@Column (name = "ba_canton")
	private Integer idCanton;
	
	@Column (name = "ba_distrito")
	private Integer idSector;
	
	@OneToMany(mappedBy = "town")
	private List<CustomerAddress> customerAddress;
	
	public Town()
	{
		
	}
	
	public Town (Integer idTown, String descriptionTown, Integer idCanton, Integer idSector)
	{
		this.idTown=idTown;
		this.descriptionTown=descriptionTown;
		this.idCanton=idCanton;
		this.idSector=idSector;
	}
	
	public Integer getIdTown()
	{
		return idTown;
	}
	
	public void setIdTown(Integer idTown)
	{
		this.idTown=idTown;
	}
	
	public String getDescriptionTown()
	{
		return descriptionTown;
	}
	
	public void setDescriptionTown(String descriptionTown)
	{
		this.descriptionTown=descriptionTown;
	}	

	public Integer getIdCanton() {
		return idCanton;
	}

	public void setIdCanton(Integer idCanton) {
		this.idCanton = idCanton;
	}

	public Integer getIdSector() {
		return idSector;
	}

	public void setIdSector(Integer idSector) {
		this.idSector = idSector;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idTown == null) ? 0 : idTown.hashCode());
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
		Town other = (Town) obj;
		if (idTown == null) {
			if (other.idTown != null)
				return false;
		} else if (!idTown.equals(other.idTown))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Town [idTown=" + idTown + ", descriptionTown="
				+ descriptionTown + ", idCanton=" + idCanton + ", idSector="
				+ idSector + ", customerAddress=" + customerAddress + "]";
	}

	



}
