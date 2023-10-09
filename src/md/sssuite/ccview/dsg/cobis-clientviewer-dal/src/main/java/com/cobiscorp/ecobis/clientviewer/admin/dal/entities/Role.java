package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "ad_rol", schema = "cobis")
/** 
 * Class used to access the database using JPA
 * related table: ad_rol bdd: cobis
 * @author ecarrion
 */
public class Role {

	@Id
	@Column(name = "ro_rol")
	private Integer code;

	@Column(name = "ro_descripcion")
	private String description;

	/** Property to declare the join with entity ManagementContentSectionByRol */
	@OneToMany(mappedBy = "role")
	private List<ManagementContentSectionRole> lstManagementContentSectionByRol;

	public int getCode() {
		return code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<ManagementContentSectionRole> getLstManagementContentSectionByRol() {
		return lstManagementContentSectionByRol;
	}

	public void setLstManagementContentSectionByRol(
			List<ManagementContentSectionRole> lstManagementContentSectionByRol) {
		this.lstManagementContentSectionByRol = lstManagementContentSectionByRol;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
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
		Role other = (Role) obj;
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
		return true;
	}

	@Override
	public String toString() {
		return "ManagementContentSection [code=" + code + ", name="
				+ description + "]";
	}

}
