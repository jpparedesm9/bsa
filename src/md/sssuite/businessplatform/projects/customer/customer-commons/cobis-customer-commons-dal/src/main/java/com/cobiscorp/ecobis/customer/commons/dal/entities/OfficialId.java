package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.io.Serializable;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "oc_oficial" and "oc_funcionario"
 * from the table: cc_oficial
 * @author bbuendia
 *
 */
@Embeddable
public class OfficialId implements Serializable {

	private Integer officialId;
	private Integer officialName;

	public OfficialId() {
	}

	public OfficialId(Integer officialId, Integer officialName) {
		this.officialId = officialId;
		this.officialName = officialName;
	}

	public Integer getOfficialId() {
		return officialId;
	}

	public void setOfficialId(Integer officialId) {
		this.officialId = officialId;
	}

	public Integer getOfficialName() {
		return officialName;
	}

	public void setOfficialName(Integer officialName) {
		this.officialName = officialName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((officialId == null) ? 0 : officialId.hashCode());
		result = prime * result
				+ ((officialName == null) ? 0 : officialName.hashCode());
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
		OfficialId other = (OfficialId) obj;
		if (officialId == null) {
			if (other.officialId != null)
				return false;
		} else if (!officialId.equals(other.officialId))
			return false;
		if (officialName == null) {
			if (other.officialName != null)
				return false;
		} else if (!officialName.equals(other.officialName))
			return false;
		return true;
	}
	
}
