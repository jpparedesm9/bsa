package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * The persistent class for the wf_rol_jerarquia database table.
 * 
 */
@Entity
@Table(name = "wf_rol_jerarquia", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "HierarchyRol.findByProcessVersionHierarchyAndRole", query = "select hr from HierarchyRol hr where hr.idProcess = :idProcess AND hr.versionProcess = :versionProcess AND hr.hierarchy.idHierarchy=:idHierarchy AND hr.idHierarchyRol.idRole=:idRole") })
public class HierarchyRol implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdHierarchyRol idHierarchyRol;

	@Column(name = "rj_asigna_manual")
	private byte manualAssigned;

	@Column(name = "rj_codigo_proceso")
	private Integer idProcess;

	@Column(name = "rj_pos_x")
	private Double positionX;

	@Column(name = "rj_pos_y")
	private Double positionY;

	@Column(name = "rj_version_proceso")
	private Short versionProcess;

	// @ManyToOne(fetch = FetchType.EAGER)
	// @JoinColumn(name = "rj_id_rol", referencedColumnName = "ro_id_rol")
	@Transient
	private Role role;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "rj_id_jerarquia", referencedColumnName = "je_id_jerarquia")
	private Hierarchy hierarchy;

	public HierarchyRol() {

	}

	/**
	 * @return the idHierarchyRol
	 */
	public IdHierarchyRol getIdHierarchyRol() {
		return idHierarchyRol;
	}

	/**
	 * @param idHierarchyRol
	 *            the idHierarchyRol to set
	 */
	public void setIdHierarchyRol(IdHierarchyRol idHierarchyRol) {
		this.idHierarchyRol = idHierarchyRol;
	}

	/**
	 * @return the manualAssigned
	 */
	public byte getManualAssigned() {
		return manualAssigned;
	}

	/**
	 * @param manualAssigned
	 *            the manualAssigned to set
	 */
	public void setManualAssigned(byte manualAssigned) {
		this.manualAssigned = manualAssigned;
	}

	/**
	 * @return the idProcess
	 */
	public Integer getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	/**
	 * @return the positionX
	 */
	public Double getPositionX() {
		return positionX;
	}

	/**
	 * @param positionX
	 *            the positionX to set
	 */
	public void setPositionX(Double positionX) {
		this.positionX = positionX;
	}

	/**
	 * @return the positionY
	 */
	public Double getPositionY() {
		return positionY;
	}

	/**
	 * @param positionY
	 *            the positionY to set
	 */
	public void setPositionY(Double positionY) {
		this.positionY = positionY;
	}

	/**
	 * @return the versionProcess
	 */
	public Short getVersionProcess() {
		return versionProcess;
	}

	/**
	 * @param versionProcess
	 *            the versionProcess to set
	 */
	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
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

	/**
	 * @return the hierarchy
	 */
	public Hierarchy getHierarchy() {
		return hierarchy;
	}

	/**
	 * @param hierarchy
	 *            the hierarchy to set
	 */
	public void setHierarchy(Hierarchy hierarchy) {
		this.hierarchy = hierarchy;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idHierarchyRol == null) ? 0 : idHierarchyRol.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		HierarchyRol other = (HierarchyRol) obj;
		if (idHierarchyRol == null) {
			if (other.idHierarchyRol != null)
				return false;
		} else if (!idHierarchyRol.equals(other.idHierarchyRol))
			return false;
		return true;
	}

}