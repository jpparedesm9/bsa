package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@IdClass(ManagementContentSectionRole.class)
@Table(name = "vcc_rol_content_management", schema = "cob_pac")
@NamedQueries({
		@NamedQuery(name = "ManagementContentSectionByRole.getManagementContentSectionRoleByRole", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO"
				+ "(mcsr.idManConSec, mcsr.idRole, r.description, mcs.name, mcs.description, mcs.urlTemplate, mcs.type)"
				+ " from ManagementContentSectionRole mcsr left join mcsr.managementContentSection mcs left join mcsr.role r "
				+ " where mcsr.idRole = :idRole"),
		@NamedQuery(name = "ManagementContentSectionByRole.getManagementContentSectionRoleBySection", query = "select new com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO"
				+ "(mcsr.idManConSec, mcsr.idRole, r.description, mcs.name, mcs.description, mcs.urlTemplate)"
				+ " from ManagementContentSectionRole mcsr left join mcsr.managementContentSection mcs left join mcsr.role r "
				+ " where mcsr.idManConSec = :idManConSec"),
		@NamedQuery(name = "ManagementContentSectionByRole.deleteManagementContentSectionRoleBySection", query = " delete from ManagementContentSectionRole mcsr "
				+ " where mcsr.idManConSec = :idManConSec"),
		@NamedQuery(name = "ManagementContentSectionRole.queryManagementContentSectionRole", query = " "
				+ "select new com.cobiscorp.ecobis.clientviewer.admin.dal.entities.ManagementContentSectionRole(m.idManConSec, m.idRole) "
				+ " from ManagementContentSectionRole m where m.idRole =:idRole and m.idManConSec=:idManConSec"),
		@NamedQuery(name = "ManagementContentSectionRole.getAllManagementContentSectionRole", query = " "
				+ "select new com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO(m.idManConSec, m.idRole) "
				+ " from ManagementContentSectionRole m ") })
/** 
 * Class used to access the database using JPA
 * related table: vcc_rol_content_management bdd: cob_pac
 * @author ecarrion
 */
public class ManagementContentSectionRole {

	/** ManagementContentSection id */
	@Id
	@Column(name = "rc_sm_id")
	private Integer idManConSec;

	/** Role code */
	@Id
	@Column(name = "rc_rol_id")
	private Integer idRole;

	/** Property to declare the join with entity ManagementContentSection */
	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "rc_sm_id", referencedColumnName = "sm_id") })
	private ManagementContentSection managementContentSection;

	/** Property to declare the join with entity Role */
	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "rc_rol_id", referencedColumnName = "ro_rol") })
	private Role role;

	public ManagementContentSectionRole(Integer idManConSec, Integer idRole) {
		super();
		this.idManConSec = idManConSec;
		this.idRole = idRole;
	}

	public ManagementContentSectionRole() {

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

	public ManagementContentSection getManagementContentSection() {
		return managementContentSection;
	}

	public void setManagementContentSection(ManagementContentSection managementContentSection) {
		this.managementContentSection = managementContentSection;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idManConSec == null) ? 0 : idManConSec.hashCode());
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
		ManagementContentSectionRole other = (ManagementContentSectionRole) obj;
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
		return "ProductManager [idRole=" + idRole + ", idProduct=" + idManConSec + "]";
	}

}
