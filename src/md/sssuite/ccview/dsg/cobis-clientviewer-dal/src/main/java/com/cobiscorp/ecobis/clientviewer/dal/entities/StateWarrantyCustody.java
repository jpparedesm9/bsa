package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "cu_estados_garantia", schema = "cob_custodia")
/**
 * Class used to access the database using JPA
 * related table: cu_estados_garantia bdd: cob_custodia
 * @author bbuendia
 *
 */
public class StateWarrantyCustody {
	@Id
	@Column(name = "eg_estado")
	private String state;
	@Column(name = "eg_descripcion")
	private String description;
	@Column(name = "eg_codvalor")
	private Integer codeValue;

	@OneToMany(mappedBy = "stateWarrantyCustody")
	private List<WarrantyTmp> warrantiesTmp;

	@OneToMany(mappedBy = "stateWarrantyCustodyOwn")
	private List<OwnWarrantyTmp> ownWarrantiesTmp;

	public StateWarrantyCustody() {
	}

	public StateWarrantyCustody(String state, String description,
			Integer codeValue) {
		this.state = state;
		this.description = description;
		this.codeValue = codeValue;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getCodeValue() {
		return codeValue;
	}

	public void setCodeValue(Integer codeValue) {
		this.codeValue = codeValue;
	}
	
	public List<WarrantyTmp> getWarrantiesTmp() {
		return warrantiesTmp;
	}

	public void setWarrantiesTmp(List<WarrantyTmp> warrantiesTmp) {
		this.warrantiesTmp = warrantiesTmp;
	}

	public List<OwnWarrantyTmp> getOwnWarrantiesTmp() {
		return ownWarrantiesTmp;
	}

	public void setOwnWarrantiesTmp(List<OwnWarrantyTmp> ownWarrantiesTmp) {
		this.ownWarrantiesTmp = ownWarrantiesTmp;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + codeValue;
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
		StateWarrantyCustody other = (StateWarrantyCustody) obj;
		if (codeValue != other.codeValue)
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
		return true;
	}

	@Override
	public String toString() {
		return "StateCustodyWarranty [state=" + state + ", description="
				+ description + ", codeValue=" + codeValue + "]";
	}
}
