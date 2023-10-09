package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "cl_ciudad", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "City.getCity", query = "select c.descriptionCity from City c where c.idCity = :idCity") })
/**
 * Class used to access the database using JPA
 * related table: cl_ciudad, bdd: cobis
 * @author bbuendia
 *
 */
public class City {

	@Id
	@Column(name = "ci_ciudad")
	private Integer idCity;

	@Column(name = "ci_descripcion")
	private String descriptionCity;

	@OneToMany(mappedBy = "city")
	private List<CustomerAddress> customerAddress;

	public City() {

	}

	public City(Integer idCity, String descriptionCity) {
		this.idCity = idCity;
		this.descriptionCity = descriptionCity;
	}

	public Integer getIdCity() {
		return idCity;
	}

	public void setIdCity(Integer idCity) {
		this.idCity = idCity;
	}

	public String getDescriptionCity() {
		return descriptionCity;
	}

	public void setDescriptionCity(String descriptionCity) {
		this.descriptionCity = descriptionCity;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idCity == null) ? 0 : idCity.hashCode());
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
		City other = (City) obj;
		if (idCity == null) {
			if (other.idCity != null)
				return false;
		} else if (!idCity.equals(other.idCity))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "City [idCity=" + idCity + ", descriptionCity="
				+ descriptionCity + ", customerAddress=" + customerAddress + "]";
	}

}
