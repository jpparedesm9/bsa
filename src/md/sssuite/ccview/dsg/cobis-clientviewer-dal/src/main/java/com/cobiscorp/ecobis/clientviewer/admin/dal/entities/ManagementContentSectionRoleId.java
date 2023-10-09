package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "rc_sm_id" and "rc_rol_id" from the table:
 * vcc_rol_content_management
 * 
 * @author ecarrion
 * 
 */

@Embeddable
public class ManagementContentSectionRoleId {
	private Integer idRole;
	private Integer idManConSec;

	public Integer getIdRole() {
		return idRole;
	}

	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
	}

	public Integer getIdManConSec() {
		return idManConSec;
	}

	public void setIdManConSec(Integer idManConSec) {
		this.idManConSec = idManConSec;
	}

	public ManagementContentSectionRoleId() {
	}

	public ManagementContentSectionRoleId(Integer idManConSec, Integer idRole) {
		super();
		this.idRole = idRole;
		this.idManConSec = idManConSec;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idManConSec == null) ? 0 : idManConSec.hashCode());
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
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
		ManagementContentSectionRoleId other = (ManagementContentSectionRoleId) obj;
		if (idManConSec == null) {
			if (other.idManConSec != null)
				return false;
		} else if (!idManConSec.equals(other.idManConSec))
			return false;
		if (idRole == null) {
			if (other.idRole != null)
				return false;
		} else if (!idRole.equals(other.idRole))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ManagementContentSectionByRolId [idRole=" + idRole
				+ ", idManConSec=" + idManConSec + "]";
	}

}
