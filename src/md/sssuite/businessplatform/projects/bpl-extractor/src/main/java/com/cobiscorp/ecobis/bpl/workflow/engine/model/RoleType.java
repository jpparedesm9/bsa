package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The persistent class for the wf_tipo_rol database table.
 * 
 */
@Entity
@Table(name = "wf_tipo_rol", schema = "cob_workflow")
public class RoleType implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdRoleType idRoleType;

	@Column(name = "tr_tipo_rol")
	private String type;

	///OneToOne
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tr_id_rol", referencedColumnName = "ro_id_rol")
	private Role role;

	public RoleType() {
	}

	/**
	 * @return the idRoleType
	 */
	public IdRoleType getIdRoleType() {
		return idRoleType;
	}

	/**
	 * @param idRoleType
	 *            the idRoleType to set
	 */
	public void setIdRoleType(IdRoleType idRoleType) {
		this.idRoleType = idRoleType;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the role
	 */
	public Role getRole() {
		return role;
	}

	/**
	 * @param role
	 *            the role to set
	 */
	public void setRole(Role role) {
		this.role = role;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idRoleType == null) ? 0 : idRoleType.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RoleType other = (RoleType) obj;
		if (idRoleType == null) {
			if (other.idRoleType != null)
				return false;
		} else if (!idRoleType.equals(other.idRoleType))
			return false;
		return true;
	}

}