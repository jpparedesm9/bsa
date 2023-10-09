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
@Table(name = "cl_pais", schema = "cobis")
@NamedQueries({
		@NamedQuery(name = "Country.getNationality", query = "select c.nationality from Country c where c.idCountry = :idCountry"),
		@NamedQuery(name = "Country.getDescription", query = "select c.descriptionCountry from Country c where c.idCountry = :idCountry") })
/**
 * Class used to access the database using JPA
 * related table: cl_pais, bdd: cobis.
 * @author bbuendia
 *
 */
public class Country {

	@Id
	@Column(name = "pa_pais")
	private Integer idCountry;

	@Column(name = "pa_descripcion")
	private String descriptionCountry;

	@Column(name = "pa_nacionalidad")
	private String nationality;

	@OneToMany(mappedBy = "country")
	private List<CustomerAddress> customerAddress;

	public Country() {
	}

	public Country(Integer idCountry, String description) {
		this.idCountry = idCountry;
		this.descriptionCountry = description;

	}

	public Integer getIdCountry() {
		return idCountry;
	}

	public void setIdCountry(Integer idCountry) {
		this.idCountry = idCountry;
	}

	public String getDescription() {
		return descriptionCountry;
	}

	public void setDescription(String description) {
		this.descriptionCountry = description;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idCountry == null) ? 0 : idCountry.hashCode());
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
		Country other = (Country) obj;
		if (idCountry == null) {
			if (other.idCountry != null)
				return false;
		} else if (!idCountry.equals(other.idCountry))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Country [idCountry=" + idCountry + ", descriptionCountry="
				+ descriptionCountry + ", customerAddress=" + customerAddress + "]";
	}

}
