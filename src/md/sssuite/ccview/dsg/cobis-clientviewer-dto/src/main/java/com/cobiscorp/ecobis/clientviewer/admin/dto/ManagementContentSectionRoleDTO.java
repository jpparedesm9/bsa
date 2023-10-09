package com.cobiscorp.ecobis.clientviewer.admin.dto;

import java.io.Serializable;

/**
 * DTO that obtains information from Management Content Section Role
 * 
 * @author ecarrion
 * 
 */
public class ManagementContentSectionRoleDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer idManConSec;
	private Integer idRole;
	private String roleDescription;
	private String manConSecName;
	private String manConSecDescription;
	private String manConSecUrl;
	private String manConSecType;

	public ManagementContentSectionRoleDTO(Integer idManConSec, Integer idRole,
			String roleDescription, String manConSecName,
			String manConSecDescription, String manConSecUrl,
			String manConSecType) {
		this.idManConSec = idManConSec;
		this.idRole = idRole;
		this.roleDescription = roleDescription;
		this.manConSecName = manConSecName;
		this.manConSecDescription = manConSecDescription;
		this.manConSecUrl = manConSecUrl;
		this.manConSecType = manConSecType;
	}
	
	public ManagementContentSectionRoleDTO(Integer idManConSec, Integer idRole,
			String roleDescription, String manConSecName,
			String manConSecDescription, String manConSecUrl) {
		this.idManConSec = idManConSec;
		this.idRole = idRole;
		this.roleDescription = roleDescription;
		this.manConSecName = manConSecName;
		this.manConSecDescription = manConSecDescription;
		this.manConSecUrl = manConSecUrl;
	}


	public ManagementContentSectionRoleDTO(Integer idManConSec, Integer idRole) {
		this.idManConSec = idManConSec;
		this.idRole = idRole;

	}

	public ManagementContentSectionRoleDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getIdManConSec() {
		return idManConSec;
	}

	public void setIdManConSec(Integer idManConSec) {
		this.idManConSec = idManConSec;
	}

	public Integer getIdRole() {
		return idRole;
	}

	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	public String getManConSecName() {
		return manConSecName;
	}

	public void setManConSecName(String manConSecName) {
		this.manConSecName = manConSecName;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getManConSecDescription() {
		return manConSecDescription;
	}

	public void setManConSecDescription(String manConSecDescription) {
		this.manConSecDescription = manConSecDescription;
	}

	public String getManConSecUrl() {
		return manConSecUrl;
	}

	public void setManConSecUrl(String manConSecUrl) {
		this.manConSecUrl = manConSecUrl;
	}

	public String getManConSecType() {
		return manConSecType;
	}

	public void setManConSecType(String manConSecType) {
		this.manConSecType = manConSecType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idManConSec == null) ? 0 : idManConSec.hashCode());
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
		result = prime * result
				+ ((roleDescription == null) ? 0 : roleDescription.hashCode());
		result = prime * result
				+ ((manConSecName == null) ? 0 : manConSecName.hashCode());
		result = prime
				* result
				+ ((manConSecDescription == null) ? 0 : manConSecDescription
						.hashCode());
		result = prime * result
				+ ((manConSecUrl == null) ? 0 : manConSecUrl.hashCode());
		result = prime * result
				+ ((manConSecType == null) ? 0 : manConSecType.hashCode());
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
		ManagementContentSectionRoleDTO other = (ManagementContentSectionRoleDTO) obj;
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
		if (roleDescription == null) {
			if (other.roleDescription != null)
				return false;
		} else if (!roleDescription.equals(other.roleDescription))
			return false;
		if (manConSecName == null) {
			if (other.manConSecName != null)
				return false;
		} else if (!manConSecName.equals(other.manConSecName))
			return false;
		if (manConSecDescription == null) {
			if (other.manConSecDescription != null)
				return false;
		} else if (!manConSecDescription.equals(other.manConSecDescription))
			return false;
		if (manConSecUrl == null) {
			if (other.manConSecUrl != null)
				return false;
		} else if (!manConSecUrl.equals(other.manConSecUrl))
			return false;
		if (manConSecType == null) {
			if (other.manConSecType != null)
				return false;
		} else if (!manConSecType.equals(other.manConSecType))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ManagementContentSectionRolDTO [idManConSec=" + idManConSec
				+ ", idRole=" + idRole + ", roleDescription=" + roleDescription
				+ ", manConSecName=" + manConSecName
				+ ", manConSecDescription=" + manConSecDescription
				+ ", manConSecUrl=" + manConSecUrl + ", manConSecType="
				+ manConSecType + "]";
	}

}
