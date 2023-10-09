package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_rol_jerarquia database table.
 * 
 */
@Embeddable
public class IdHierarchyRol implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "rj_id_jerarquia")
	private Integer idHierarchy;

	@Column(name = "rj_id_rol")
	private Integer idRole;

	public IdHierarchyRol() {
	}

	public IdHierarchyRol(Integer idHierarchy, Integer idRole) {
		super();
		this.idHierarchy = idHierarchy;
		this.idRole = idRole;
	}

	/**
	 * @return the idHierarchy
	 */
	public Integer getIdHierarchy() {
		return idHierarchy;
	}

	/**
	 * @param idHierarchy
	 *            the idHierarchy to set
	 */
	public void setIdHierarchy(Integer idHierarchy) {
		this.idHierarchy = idHierarchy;
	}

	/**
	 * @return the idRole
	 */
	public Integer getIdRole() {
		return idRole;
	}

	/**
	 * @param idRole
	 *            the idRole to set
	 */
	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
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
		result = prime * result + ((idHierarchy == null) ? 0 : idHierarchy.hashCode());
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
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
		IdHierarchyRol other = (IdHierarchyRol) obj;
		if (idHierarchy == null) {
			if (other.idHierarchy != null)
				return false;
		} else if (!idHierarchy.equals(other.idHierarchy))
			return false;
		if (idRole == null) {
			if (other.idRole != null)
				return false;
		} else if (!idRole.equals(other.idRole))
			return false;
		return true;
	}

}