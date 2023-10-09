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
@Table(name = "cl_sector_economico", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "EconomicSector.findDescription", query = "select a.description from EconomicSector a where a.code = :code") })
/**
 * Class used to access the database using JPA
 * related table: cl_actividad_ec, bdd: cobis
 *
 */
public class EconomicSector {

	@Id
	@Column(name = "se_codigo")
	private String code;

	@Column(name = "se_descripcion")
	private String description;

	@Column(name = "se_estado")
	private String state;

	@Column(name = "se_codFuentIng")
	private String codSourceInc;

	@OneToMany(mappedBy = "economicSector")
	private List<SubSector> lstSubsector;

	public EconomicSector() {
	}

	public EconomicSector(String code, String description) {
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

	public String getCodSourceInc() {
		return codSourceInc;
	}

	public void setCodSourceInc(String codSourceInc) {
		this.codSourceInc = codSourceInc;
	}

	public List<SubSector> getLstSubsector() {
		return lstSubsector;
	}

	public void setLstSubsector(List<SubSector> lstSubsector) {
		this.lstSubsector = lstSubsector;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result
				+ ((codSourceInc == null) ? 0 : codSourceInc.hashCode());
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
		EconomicSector other = (EconomicSector) obj;
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
		if (codSourceInc == null) {
			if (other.codSourceInc != null)
				return false;
		} else if (!codSourceInc.equals(other.codSourceInc))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Activity [code=" + code + ", description=" + description
				+ ", state=" + state + ", codSourceInc=" + codSourceInc + "]";
	}
}
