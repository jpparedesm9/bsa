package com.cobiscorp.ecobis.customer.commons.dal.entities;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "cl_subsector_ec", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "SubSector.findDescription", query = "select a.description from SubSector a where a.code = :code") })
/**
 * Class used to access the database using JPA
 * related table: cl_actividad_ec, bdd: cobis
 *
 */
public class SubSector {

	@Id
	@Column(name = "se_codigo")
	private String code;

	@Column(name = "se_descripcion")
	private String description;

	@Column(name = "se_estado")
	private String state;

	@ManyToOne
	@JoinColumn(name = "se_codSector", referencedColumnName = "se_codigo")
	private EconomicSector economicSector;

	public SubSector() {
	}

	public SubSector(String code, String description) {
		this.code = code;
		this.description = description;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public EconomicSector getEconomicSector() {
		return economicSector;
	}

	public void setEconomicSector(EconomicSector economicSector) {
		this.economicSector = economicSector;
	}	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
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
		SubSector other = (SubSector) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (economicSector == null) {
			if (other.economicSector != null)
				return false;
		} else if (!economicSector.equals(other.economicSector))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Activity [code=" + code + ", description=" + description
				+ ", state=" + state + "]";
	}
}
